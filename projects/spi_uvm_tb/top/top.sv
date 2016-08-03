
`include "uvm_macros.svh"

module top;

  import uvm_pkg::*;
  import spi_test_pkg::*;

  bit clock;

   initial
   forever #10 clock = ~clock;
  
   spi_intf intf(clock);


   initial
     begin

	uvm_config_db#(virtual spi_intf)::set(null, "*", "vif", intf);

	run_test();
	
     end
   
   
endmodule // top
