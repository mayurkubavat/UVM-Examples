class spi_env_config extends uvm_object;

	`uvm_object_utils(spi_env_config)

	virtual spi_intf vif;

	spi_master_config spi_master_cfg;
	spi_slave_config spi_slave_cfg;

	function new(string name = "spi_env_config");
		super.new(name);
	endfunction

endclass //spi_env_config
