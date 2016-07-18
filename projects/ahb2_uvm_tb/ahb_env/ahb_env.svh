/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Environment
 Filename: ahb_env.svh
**********************************************************/

class ahb_env extends uvm_env;

        `uvm_component_utils(ahb_env)

        env_config env_cfg;
        ahb_magent_config magt_cfg;
        ahb_sagent_config sagt_cfg;

        reset_agent reset_agent_h;
        ahb_magent master_agent_h;
        ahb_sagent slave_agent_h;

        ahb_coverage ahb_coverage_h;
        ahb_vseqr vseqr_h;

        uvm_analysis_port#(ahb_mxtn) ahb_master_ap;
        uvm_analysis_port#(ahb_sxtn) ahb_slave_ap;


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_env", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
endclass: ahb_env

        //Constructor
        function ahb_env::new(string name = "ahb_env", uvm_component parent);
                super.new(name, parent);

                ahb_master_ap = new("ahb_master_ap", this);
                ahb_slave_ap = new("ahb_slave_ap", this);
        endfunction

        //Build
        function void ahb_env::build_phase(uvm_phase phase);
                if(!uvm_config_db#(env_config)::get(this, "", "env_config", env_cfg))
                begin
                        `uvm_fatal(get_full_name(), "Cannot get ENV-CONFIG from configuration database!")
                end

                uvm_config_db#(virtual ahb_intf)::set(this, "reset_agent*", "reset_controller", env_cfg.vif);

                // Set master agent configuration       
                magt_cfg = ahb_magent_config::type_id::create("magt_cfg");
                magt_cfg.vif = env_cfg.vif;
                magt_cfg.is_active = env_cfg.m_is_active;
                uvm_config_db#(ahb_magent_config)::set(this, "master_agent*", "ahb_magent_config", magt_cfg);


                // Set slave agent configuration        
                sagt_cfg = ahb_sagent_config::type_id::create("sagt_cfg");
                sagt_cfg.vif = env_cfg.vif;
                sagt_cfg.is_active = env_cfg.s_is_active;
                uvm_config_db#(ahb_sagent_config)::set(this, "slave_agent*", "ahb_sagent_config", sagt_cfg);

                super.build_phase(phase);

                reset_agent_h = reset_agent::type_id::create("reset_agent_h", this);
                master_agent_h = ahb_magent::type_id::create("master_agent_h", this);
                slave_agent_h = ahb_sagent::type_id::create("slave_agent_h", this);

                ahb_coverage_h = ahb_coverage::type_id::create("ahb_coverage_h", this);

                vseqr_h = ahb_vseqr::type_id::create("vseqr_h", this);

        endfunction

        //Connect
        function void ahb_env::connect_phase(uvm_phase phase);
                master_agent_h.agent_ap.connect(ahb_coverage_h.analysis_export);
                master_agent_h.agent_ap.connect(ahb_master_ap);
                slave_agent_h.agent_ap.connect(ahb_slave_ap);

                vseqr_h.reset_seqr_h = reset_agent_h.reset_seqr_h;

                if(magt_cfg.is_active == UVM_ACTIVE)
                begin
                        vseqr_h.mseqr_h = master_agent_h.mseqr_h;
                end

                if(sagt_cfg.is_active == UVM_ACTIVE)
                begin
                        vseqr_h.sseqr_h = slave_agent_h.sseqr_h;
                end
        endfunction

