module top;

   import uvm_pkg::*;

   `include "uvm_macros.svh"

   `include "my_component.svh"
   `include "my_test.svh"

   bit clock;
   initial forever #10 clock = !clock;

   my_interface my_if();
   assign my_if.clock = clock;


   initial
   begin
      uvm_config_db#(virtual my_interface)::set(null, "*", "my_interface", my_if);
      run_test("my_test");
   end


endmodule

