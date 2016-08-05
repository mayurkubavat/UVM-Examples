class spi_master_config extends uvm_object;

	`uvm_object_utils(spi_master_config)

	virtual spi_intf vif;

	function new(string name = "spi_master_config");
		super.new(name);
	endfunction

endclass //spi_master_config
