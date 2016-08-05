class spi_base_test extends uvm_test;

	`uvm_component_utils(spi_base_test)

	spi_env spi_env_h;

	spi_env_config env_cfg_h;

	function new(string name = "spi_base_test", uvm_component parent);
		super.new(name, parent);
	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		env_cfg_h = spi_env_config::type_id::create("env_cfg_h");
		uvm_config_db#(spi_env_config)::set(this, "*", "env_cfg", env_cfg_h);

		spi_env_h = spi_env::type_id::create("spi_env_h", this);
	endfunction

	function void connect_phase(uvm_phase phase);

	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		print(); // Print testbench topology
	endfunction

endclass //spi_base_test
