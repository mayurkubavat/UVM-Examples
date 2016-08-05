class spi_master_monitor extends uvm_monitor;

	`uvm_component_utils(spi_master_monitor)


	function new(string name = "spi_master_monitor", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction


endclass //spi_master_monitor

