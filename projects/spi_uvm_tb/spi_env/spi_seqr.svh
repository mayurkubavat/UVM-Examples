class spi_seqr extends uvm_sequencer#(spi_transaction);

	`uvm_component_utils(spi_seqr)

	function new(string name = "spi_seqr", uvm_component parent);
		super.new(name, parent);
	endfunction

endclass //spi_seqr
