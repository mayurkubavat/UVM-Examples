module top;
   
   import uvm_pkg::*;
   `include "uvm_macros.svh"

   `include "my_component_1.svh"
   `include "my_component_2.svh"
   `include "test.svh"

   bit clock;
   my_interface my_intf();

   assign my_intf.clock = clock;

   initial forever #10 clock = !clock;


   initial
   begin
      uvm_config_db#(virtual my_interface)::set(null, "*", "my_interface", my_intf);
      run_test("test");
   end

endmodule

