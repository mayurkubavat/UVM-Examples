/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master UVC
 Filename: ahb_magent.svh
**********************************************************/

class ahb_magent extends uvm_agent;

        `uvm_component_utils(ahb_magent)

        ahb_mdriver mdriver_h;
        ahb_mmonitor mmonitor_h;
        ahb_mseqr mseqr_h;

        uvm_analysis_port#(ahb_mxtn) agent_ap;

        ahb_magent_config magt_cfg;

        uvm_active_passive_enum is_active;

        //--------------------------------------------
        // Methods
        //--------------------------------------------

        extern function new(string name = "ahb_magent", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

endclass: ahb_magent

        //Constructor
        function ahb_magent::new(string name = "ahb_magent", uvm_component parent);
                super.new(name, parent);
                agent_ap = new("agent_ap", this);
        endfunction

        //Build
        function void ahb_magent::build_phase(uvm_phase phase);
                if(!uvm_config_db#(ahb_magent_config)::get(this, "", "ahb_magent_config", magt_cfg))
                begin
                        `uvm_fatal(get_full_name(), "Cannot get AGENT-CONFIG from configuration database!")
                end

                is_active = magt_cfg.is_active;

                super.build_phase(phase);

                mmonitor_h = ahb_mmonitor::type_id::create("mmonitor_h", this);
                if(is_active == UVM_ACTIVE)
                begin
                        mdriver_h = ahb_mdriver::type_id::create("mdriver_h", this);
                        mseqr_h = ahb_mseqr::type_id::create("mseqr_h", this);
                end
        endfunction

        //Connect
        function void ahb_magent::connect_phase(uvm_phase phase);
                mmonitor_h.monitor_ap.connect(agent_ap);

                if(is_active == UVM_ACTIVE)
                begin
                        mdriver_h.seq_item_port.connect(mseqr_h.seq_item_export);
                end
        endfunction

