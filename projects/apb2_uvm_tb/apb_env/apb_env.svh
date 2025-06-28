class apb_env extends uvm_env;

    `uvm_component_utils(apb_env)


    apb_env_config m_env_cfg;


    //Configuration for ABP Bridge and Slave
    apb_requester_config m_bridge_cfg;

    apb_completer_config m_slave_cfg;


    //APB Subscriber to generate coverage
    apb_subscriber apb_subscriber_h;


    apb_requester  apb_requester_h;
    apb_completer   apb_completer_h;
    reset_agent reset_agent_h;


    apb_seqr    m_bridge_seqr_h;
    apb_seqr    m_slave_seqr_h;
    reset_seqr  reset_seqr_h;


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new


    function void build_phase(uvm_phase phase);

        if(!uvm_config_db#(apb_env_config)::get(this, "", "apb_env_config", m_env_cfg))
            `uvm_fatal("APB_ENV", {get_full_name(), " Cannot get environmet configuration object from test"})

        if(m_env_cfg.has_coverage)
        begin
            apb_subscriber_h = apb_subscriber::type_id::create("apb_subscriber_h", this);
        end

        //Set master agent(APB Bridge) configuration       
        m_bridge_cfg = apb_requester_config::type_id::create("m_bridge_cfg");
        m_bridge_cfg.apb_intf = m_env_cfg.apb_intf;
        m_bridge_cfg.is_active = m_env_cfg.bridge_is_active;
        uvm_config_db#(apb_requester_config)::set(this, "apb_requester*", "apb_requester_config", m_bridge_cfg);

        //Set slave agent(APB Slave) configuration       
        m_slave_cfg = apb_completer_config::type_id::create("m_slave_cfg");
        m_slave_cfg.apb_intf = m_env_cfg.apb_intf;
        m_slave_cfg.is_active = m_env_cfg.slave_is_active;
        uvm_config_db#(apb_completer_config)::set(this, "apb_completer*", "apb_completer_config", m_slave_cfg);


        apb_requester_h = apb_requester::type_id::create("apb_requester_h", this);

        apb_completer_h = apb_completer::type_id::create("apb_completer_h", this);

        reset_agent_h = reset_agent::type_id::create("reset_agent_h", this);

    endfunction //build_phase


    function void connect_phase(uvm_phase phase);

        m_bridge_seqr_h = apb_requester_h.m_bridge_seqr_h;
        m_slave_seqr_h = apb_completer_h.m_slave_seqr_h;
        reset_seqr_h = reset_agent_h.reset_seqr_h;
    endfunction //connect_phase

endclass //apb_env

