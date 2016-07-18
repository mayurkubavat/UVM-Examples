/**********************************************************
 Start Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Slave UVC
 Filename: ahb_sagent.svh
**********************************************************/

class ahb_sagent extends uvm_agent;

        `uvm_component_utils(ahb_sagent)


        ahb_sdriver sdriver_h;
        ahb_smonitor smonitor_h;
        ahb_sseqr sseqr_h;

        uvm_analysis_port#(ahb_sxtn) agent_ap;

        ahb_sagent_config sagt_cfg;
        uvm_active_passive_enum is_active;

        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "ahb_sagent", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

endclass: ahb_sagent

        //Constructor
        function ahb_sagent::new(string name = "ahb_sagent", uvm_component parent);
                super.new(name, parent);
                agent_ap = new("agent_ap", this);
        endfunction

        //Build
        function void ahb_sagent::build_phase(uvm_phase phase);
                if(!uvm_config_db#(ahb_sagent_config)::get(this, "", "ahb_sagent_config", sagt_cfg))
                begin
                        `uvm_fatal(get_full_name(), "Cannot get AGENT-CONFIG from configuration database!")
                end

                is_active = sagt_cfg.is_active;

                super.build_phase(phase);

                smonitor_h = ahb_smonitor::type_id::create("smonitor_h", this);
                if(is_active == UVM_ACTIVE)
                begin
                        sdriver_h = ahb_sdriver::type_id::create("sdriver_h", this);
                        sseqr_h = ahb_sseqr::type_id::create("sseqr_h", this);
                end
        endfunction

        //Connect
        function void ahb_sagent::connect_phase(uvm_phase phase);
                agent_ap.connect(smonitor_h.monitor_ap);

                if(is_active == UVM_ACTIVE)
                begin
                        sdriver_h.seq_item_port.connect(sseqr_h.seq_item_export);
                end
        endfunction


