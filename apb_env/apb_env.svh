class apb_env extends uvm_env;

    `uvm_component_utils(apb_env)


    apb_env_config m_env_cfg;


    //Configuration for ABP Bridge and Slave
    apb_bridge_config m_bridge_cfg;

    apb_slave_config m_slave_cfg;


    //APB Subscriber to generate coverage
    apb_subscriber apb_subscriber_h;


    apb_bridge apb_bridge_h;

    apb_slave apb_slave_h;


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

        apb_bridge_h = apb_bridge::type_id::create("apb_bridge_h", this);

        apb_slave_h = apb_slave::type_id::create("apb_slave_h", this);

    endfunction //build_phase


    function void connect_phase(uvm_phase phase);

    endfunction //connect_phase

endclass //apb_env

