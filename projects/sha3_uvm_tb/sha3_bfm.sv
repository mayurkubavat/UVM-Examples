/*
	Description: Bus Functton Model(BFM) in UVM environment.
	Author: Mayur Kubavat
	Date: 03 Apr 2015
	Purpose:
	-> Defines interface to Keccak SHA-3 DUT, Low Throughput Core
	-> Meets timing specification of the Core.
	-> Defines clock.
*/

`timescale 1ns / 1ps
`define P 20

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


	task send_bfm(
				input bit reset_t,
				input logic [31:0] in_t,
				input logic in_ready_t,
				input logic is_last_t,
				input logic byte_num_t,
				output logic buffer_full_t,
				output logic [511:0] out_t,
				output logic out_ready_t
				);
		
		if(reset_t) begin
			@(posedge clk)
			reset = 1'b0;
			in = 1'b0;
			in_ready = 1'b0;
			is_last = 1'b0;
			byte_num = 1'b0;
			@(posedge clk)
			reset = 1'b1;
			#(10*`P);
		end else begin
				reset = 1'b0;
				always(in_t) begin
					in_ready = in_ready_t;
					if(in_ready) begin
						if(!is_last_t) begin
							is_last = 1'b0;
							in = in_t;
							#(`P);
						end else begin
							is_last = 1'b1;
							in = in_t;
							byte_num = byte_num_t;
							#(`P)
							in_ready = 1'b0;
							is_last = 1'b0;
						end
					end else begin
						is_last = 1'b0;
						in = in;
					end
				end //always block
		end
		
	endtask: send_bfm


   initial begin
      clk = 0;
      fork
         forever begin
            #10;
            clk = ~clk;
         end
      join_none
   end

endinterface: sha3_intf

`undef P
