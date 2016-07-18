class apb_bridge_monitor extends uvm_monitor;

    `uvm_component_utils(apb_bridge_monitor)

    virtual apb_if apb_intf;

    apb_bridge_config bridge_cfg_h;

    uvm_analysis_port#(apb_xtn) monitor_ap;

    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);

        monitor_ap = new("monitor_ap", this);
    endfunction //new

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(apb_bridge_config)::get(this, "", "apb_bridge_config", bridge_cfg_h))
        begin
            `uvm_fatal("APB/BRIDGE/MON", "Cannot get VIF from configuration database!")
        end

        super.build_phase(phase);
    endfunction //build_phase

    function void connect_phase(uvm_phase phase);
        apb_intf = bridge_cfg_h.apb_intf;

        super.connect_phase(phase);
    endfunction //connect_phase

    task run_phase(uvm_phase phase);

    endtask //run_phase

endclass //apb_bridge_monitor

