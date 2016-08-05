class spi_transaction extends uvm_sequence_item;

	`uvm_object_utils(spi_transaction)

	function new(string name = "spi_transaction");
		super.new(name);
	endfunction

endclass //spi_transaction
