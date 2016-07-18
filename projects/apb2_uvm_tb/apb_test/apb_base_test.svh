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


    virtual apb_if apb_intf;

    //APB test environment configuration
    apb_env_config m_env_cfg;


    apb_env apb_env_h;

    apb_seqr m_bridge_seqr_h;
    apb_seqr m_slave_seqr_h;

    reset_seqr reset_seqr_h;


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    //Build
    function void build_phase(uvm_phase phase);

        if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_if", apb_intf))
            `uvm_fatal("APB_TEST", {get_full_name(), " Cannot get APB Interface from top"})

        super.build_phase(phase);


        m_env_cfg = apb_env_config::type_id::create("m_env_cfg");

        m_env_cfg.apb_intf = this.apb_intf;


        //Set environment configuration for lower level components
        uvm_config_db#(apb_env_config)::set(this, "*", "apb_env_config", m_env_cfg);
        uvm_config_db#(virtual apb_if)::set(this, "*", "reset_controller", apb_intf);

        apb_env_h = apb_env::type_id::create("apb_env_h", this);

    endfunction //build_phase


    //Connect
    function void connect_phase(uvm_phase phase);

        m_bridge_seqr_h = apb_env_h.m_bridge_seqr_h;
        m_slave_seqr_h = apb_env_h.m_slave_seqr_h;

        reset_seqr_h = apb_env_h.reset_seqr_h;

    endfunction //connect_phase


    //Elaboration
    function void end_of_elaboration_phase(uvm_phase phase);
        //Print topology
        uvm_top.print_topology();
    endfunction //end_of_elaboration_phase


endclass //apb_base_test

