class spi_base_test extends uvm_test;

	`uvm_component_utils(spi_base_test)


	function new(string name = "spi_base_test", uvm_component parent);
		super.new(name, parent);
	endfunction

endclass //spi_base_test
