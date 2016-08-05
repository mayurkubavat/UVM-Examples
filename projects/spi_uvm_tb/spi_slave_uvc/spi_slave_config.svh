class spi_slave_config extends uvm_object;

	`uvm_object_utils(spi_slave_config)

	virtual spi_intf vif;

	function new(string name = "spi_slave_config");
		super.new(name);
	endfunction

endclass //spi_slave_config
