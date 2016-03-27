//
// ABP base test
// - Get virtual interface from top module
// - Create and configure APB environment
//
// Date: 27/03/2016
// Author: Mayur Kubavat
//

class apb_base_test extends uvm_test;

    `uvm_component_utils(apb_base_test)


    virtual apb_if m_apb_if;

    //APB test environment configuration
    apb_env_config m_env_cfg;


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    //Build
    function void build_phase(uvm_phase phase);

        if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_if", m_apb_if))
            `uvm_fatal("APB_TEST", {get_full_name(), " Cannot get APB Interface from top"})

        super.build_phase(phase);


        m_env_cfg = apb_env_config::type_id::create("m_env_cfg");

        m_env_cfg.m_apb_if = this.m_apb_if;


        //Set environment configuration for lower level components
        uvm_config_db#(apb_env_config)::set(this, "*", "apb_env_config", m_env_cfg);

    endfunction //build_phase

endclass //apb_base_test

