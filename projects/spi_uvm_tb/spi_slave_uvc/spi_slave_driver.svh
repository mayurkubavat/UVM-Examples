class spi_slave_driver extends uvm_driver#(spi_transaction);

	`uvm_component_utils(spi_slave_driver)


	function new(string name = "spi_slave_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction


endclass //spi_slave_driver

