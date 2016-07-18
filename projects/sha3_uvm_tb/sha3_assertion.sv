module sha3_assertion(	clk,
						reset,
						in,
						in_ready,
						is_last,
						byte_num,
						buffer_full,
						out,
						out_ready
						);
	
	input logic clk, reset;
	input logic [31:0] in;
	input logic in_ready;
	input logic is_last;
	input logic [1:0] byte_num;
	input logic buffer_full;
	input logic [511:0] out;
	input logic out_ready;
	
	
	property valid_out_prpty;
		@(posedge clk) disable iff(reset)
		is_last |=> ##41 out_ready;
	endproperty
	
	/*
	property buffer_full_prpty;
		@(posedge clk) disable iff(reset)
		$rose(in_ready) |=> ##23 buffer_full;
	endproperty
	*/
	
	VALID_OUT: assert property(valid_out_prpty);
	//BUF_FULL: assert property(buffer_full_prpty);
	
endmodule