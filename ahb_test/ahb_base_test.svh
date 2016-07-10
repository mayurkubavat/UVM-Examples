/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Test
 Filename: ahb_base_test.svh
**********************************************************/

class ahb_base_test extends uvm_test;

        `uvm_component_utils(ahb_base_test)

        ahb_env env_h;

        virtual ahb_intf vif;

        uvm_active_passive_enum m_is_active;
        uvm_active_passive_enum s_is_active;

        env_config env_cfg;


        ahb_reset_vseq reset_vseq_h;
        ahb_set_vseq set_vseq_h;

        ahb_idle_vseq idle_vseq_h;
        ahb_incrx_vseq incrx_vseq_h;
        ahb_wrapx_vseq wrapx_vseq_h;
        ahb_crt_vseq crt_vseq_h;
        ahb_incrbusy_vseq incrbusy_vseq_h;

        ahb_ready_vseq ready_vseq_h;
        ahb_err_vseq err_vseq_h;

        //--------------------------------------------------
        // Methods
        //--------------------------------------------------

        extern function new(string name = "ahb_base_test", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: ahb_base_test

//Constructor
function ahb_base_test::new(string name = "ahb_base_test", uvm_component parent);
        super.new(name, parent);
endfunction

function void ahb_base_test::build_phase(uvm_phase phase);
        env_cfg = env_config::type_id::create("env_cfg");

        if(!uvm_config_db#(virtual ahb_intf)::get(this, "", "ahb_intf", vif))
        begin
                `uvm_fatal(get_full_name(), "Cannot get VIF from configuration database!")
        end

        env_cfg.vif = vif;

        m_is_active = UVM_ACTIVE;
        s_is_active = UVM_ACTIVE;

        env_cfg.m_is_active = m_is_active;
        env_cfg.s_is_active = s_is_active;

        uvm_config_db#(env_config)::set(this, "*", "env_config", env_cfg);

        super.build_phase(phase);

        env_h = ahb_env::type_id::create("env_h", this);
endfunction

function void ahb_base_test::end_of_elaboration_phase(uvm_phase phase);
        print();
endfunction


