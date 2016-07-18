/*
	Description: Interface block in UVM environment.
	Author: Mayur Kubavat
	Date: 15 Feb 2015
	Purpose:
	-> Defines interface to Keccak SHA-3 DUT, Low Throughput Core
*/

interface sha3_intf;

	logic clk;
	logic reset;
	logic [31:0] in;
	logic 	in_ready;
	logic 	is_last;
	logic [1:0] 	byte_num;
	logic 	buffer_full;
	logic [511:0] out;
	logic 	 out_ready;
	
endinterface: sha3_intf
