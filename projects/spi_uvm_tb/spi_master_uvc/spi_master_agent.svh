class spi_master_agent extends uvm_agent;

	`uvm_component_utils(spi_master_agent)

	spi_master_driver  spi_master_driver_h;
	spi_seqr           spi_seqr_h;
	spi_master_monitor spi_master_monitor_h;

	function new(string name = "spi_master_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		spi_master_driver_h = spi_master_driver::type_id::create("spi_master_driver_h", this);
		spi_seqr_h = spi_seqr::type_id::create("spi_seqr_h", this);

		spi_master_monitor_h = spi_master_monitor::type_id::create("spi_master_monitor_h", this);

	endfunction


endclass //spi_master_agent

