class spi_master_driver extends uvm_driver#(spi_transaction);

	`uvm_component_utils(spi_master_driver)


	function new(string name = "spi_master_driver", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction


endclass //spi_master_driver

