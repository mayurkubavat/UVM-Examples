class apb_requester extends uvm_agent;
  `uvm_component_utils(apb_requester)

  apb_requester_driver  m_bridge_driver_h;
  apb_requester_monitor m_bridge_monitor_h;
  apb_seqr              m_bridge_seqr_h;

  uvm_analysis_port#(apb_xtn) agent_ap;

  apb_requester_config    bridge_cfg;
  uvm_active_passive_enum is_active;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    agent_ap = new("agent_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(apb_requester_config)::get(this, "", "apb_requester_config", bridge_cfg)) begin
      `uvm_fatal(get_full_name(), "Cannot get AGENT-CONFIG from configuration database!")
    end

    is_active = bridge_cfg.is_active;

    super.build_phase(phase);

    if(is_active == UVM_ACTIVE) begin
      m_bridge_driver_h = apb_requester_driver::type_id::create("m_bridge_driver_h", this);
      m_bridge_seqr_h   = apb_seqr::type_id::create("m_bridge_seqr_h", this);
    end

    m_bridge_monitor_h = apb_requester_monitor::type_id::create("m_bridge_monitor_h", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    if(is_active == UVM_ACTIVE) begin
      m_bridge_driver_h.seq_item_port.connect(m_bridge_seqr_h.seq_item_export);
    end

    m_bridge_monitor_h.monitor_ap.connect(agent_ap);
  endfunction

endclass: apb_requester
