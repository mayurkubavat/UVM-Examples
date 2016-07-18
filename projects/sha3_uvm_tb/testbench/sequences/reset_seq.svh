/*
	Description: Reset Sequence in UVM environment.
	Author: Mayur Kubavat
	Date: 26 Feb 2015
	Purpose:
	-> Implements body() method to toggle reset signal.
*/

class reset_seq extends uvm_sequence#(sequence_item);
	`uvm_object_utils(reset_seq)
	
	sequence_item command;
	
	function new(string name = "reset_seq");
		super.new(name);
	endfunction: new

	task body();
		bit rst = 1;
		command = sequence_item::type_id::create("command");
		repeat(2) begin
		start_item(command);
		command.reset = rst;
		finish_item(command);
		#15 rst = ~rst;
		end
	endtask: body

endclass: reset_seq
	