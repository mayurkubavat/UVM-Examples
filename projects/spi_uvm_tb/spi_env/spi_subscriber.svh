class spi_subscriber extends uvm_subscriber#(spi_transaction);

	`uvm_component_utils(spi_subscriber)

	function new(string name = "spi_subscriber", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void write(spi_transaction t);

	endfunction

endclass //spi_subscriber

