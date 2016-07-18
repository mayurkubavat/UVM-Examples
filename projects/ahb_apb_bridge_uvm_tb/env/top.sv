/*****************************************************************
 * Filename: top.sv
 * Module Name: top
 * Author: Mayur
 * Creation Date: Aug 2015
 * Completion Date: Aug 2015
 * --------------------------------------------------------------
 *  -> Instantiate DUT and INTERFACE, Clock
 *  -> Call run_test() available in uvm_pkg
 * **************************************************************/

module top;

	//Import Packages
	import uvm_pkg::*;
	import test_pkg::*;

	//Define and Start Clock
	bit clock;
	
	initial
	begin
		clock = 0;
		forever #10 clock = !clock;
	end
	
	//Interface Instance
	ahb_if ahb_intf(clock);
	apb_if apb_intf();

	//Design Instance
	//	DUV();

	initial
	begin
		//Set Interface
		uvm_config_db#(virtual ahb_if)::set(null, "*", "ahb_vif", ahb_intf);
		uvm_config_db#(virtual apb_if)::set(null, "*", "apb_vif", apb_intf);
		
		//Run Tests
		run_test();
	end

endmodule
 
