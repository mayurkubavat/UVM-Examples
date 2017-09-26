module top;

   `include "uvm_macros.svh"
   import uvm_pkg::*;
   import interfacePackage::*;
   
   `include "my_base_test.sv"

   bit clock;
   initial forever #10 clock = !clock;
      
   myInterface intf(clock);

   full_adder fa(
      .sum(intf.sum), 
      .carry(intf.carry), 
      .inp(intf.inp[2:0])
   );


   initial
   begin
      uvm_config_db#(virtual myInterface)::set(null, "*", "vif", intf);
      run_test("my_base_test");
   end

endmodule
