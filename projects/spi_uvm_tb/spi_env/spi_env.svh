class spi_env extends uvm_test;

	`uvm_component_utils(spi_env)

	spi_master_agent spi_master_agent_h;
	spi_slave_agent  spi_slave_agent_h;

	spi_subscriber spi_subscriber_h;

	spi_env_config env_cfg_h;

	function new(string name = "spi_env", uvm_component parent);
		super.new(name, parent);
	endfunction


	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		if(!uvm_config_db#(spi_env_config)::get(this, "", "env_cfg", env_cfg_h))
			`uvm_fatal("SPI_ENV/CFG", "Cannot get env-config! Check settings.")

		spi_master_agent_h = spi_master_agent::type_id::create("spi_master_agent_h", this);
		spi_slave_agent_h  = spi_slave_agent::type_id::create("spi_slave_agent_h", this);

		spi_subscriber_h = spi_subscriber::type_id::create("spi_subscriber_h", this);

	endfunction

	function void connect_phase(uvm_phase phase);

	endfunction

endclass //spi_env
