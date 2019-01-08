module top;

   import uvm_pkg::*;
   `include "uvm_macros.svh"

   `include "report_catcher.svh"
   `include "env.svh"
   `include "test.svh"
   


   initial
   begin
      run_test("test");
   end

endmodule

