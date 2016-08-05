
class spi_slave_monitor extends uvm_monitor;

	`uvm_component_utils(spi_slave_monitor)


	function new(string name = "spi_slave_monitor", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction


endclass //spi_slave_monitor

