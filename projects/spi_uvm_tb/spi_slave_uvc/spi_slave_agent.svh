class spi_slave_agent extends uvm_agent;

	`uvm_component_utils(spi_slave_agent)

	spi_slave_driver  spi_slave_driver_h;
	spi_slave_monitor spi_slave_monitor_h;

	function new(string name = "spi_slave_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		spi_slave_driver_h  = spi_slave_driver::type_id::create("spi_slave_driver_h", this);
		spi_slave_monitor_h = spi_slave_monitor::type_id::create("spi_slave_monitor_h", this);

	endfunction

endclass //spi_slave_agent

