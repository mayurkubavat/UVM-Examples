/*
	Description: Control Sequence in UVM environment.
	Author: Mayur Kubavat
	Date: 05 March 2015
	Purpose:
	-> Configures Keccak SHA-3 Signals before sending Input String. 
*/

class strt_ctrl_seq extends uvm_sequence#(sequence_item);
	`uvm_object_utils(strt_ctrl_seq)
	
	sequence_item command;
	
	function new(string name = "strt_ctrl_seq");
		super.new(name);
	endfunction: new

	task body();
		command = sequence_item::type_id::create("command");

		start_item(command);
		command.reset = 0;
		command.byte_num = 0;
        command.in_ready = 1; 
		command.is_last = 0;
		finish_item(command);

	endtask: body

endclass: strt_ctrl_seq
	