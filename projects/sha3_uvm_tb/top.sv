/*
	Description: Top module in UVM environment.
	Author: Mayur Kubavat
	Date: 15 Feb 2015
	Purpose:
	-> Connects Keccak SHA-3 DUT and Interface,
	-> Implement Virtual Interface,
	-> Run test specified by +UVM_TESTNAME
*/

module top;

	import uvm_pkg::*;
	import sha3_pkg::*;
   
`include "uvm_macros.svh"

	sha3_intf sha3_if();

	keccak dut(
			.clk(sha3_if.clk),
			.reset(sha3_if.reset),
			.in(sha3_if.in),
			.in_ready(sha3_if.in_ready),
			.is_last(sha3_if.is_last),
			.byte_num(sha3_if.byte_num),
			.buffer_full(sha3_if.buffer_full),
			.out(sha3_if.out),
			.out_ready(sha3_if.out_ready)
			);
			
	bind dut sha3_assertion SVA(
								.clk(sha3_if.clk),
								.reset(sha3_if.reset),
								.in(sha3_if.in),
								.in_ready(sha3_if.in_ready),
								.is_last(sha3_if.is_last),
								.byte_num(sha3_if.byte_num),
								.buffer_full(sha3_if.buffer_full),
								.out(sha3_if.out),
								.out_ready(sha3_if.out_ready)
								);
			
	initial begin
		sha3_if.clk = 0;
		forever #10 sha3_if.clk = ~sha3_if.clk;
	end

	initial begin
		uvm_config_db#(virtual sha3_intf)::set(null, "*", "sha3_vif", sha3_if);
		run_test();
	end

endmodule: top
