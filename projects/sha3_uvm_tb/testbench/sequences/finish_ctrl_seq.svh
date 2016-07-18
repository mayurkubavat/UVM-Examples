/*
	Description: Control Sequence in UVM environment.
	Author: Mayur Kubavat
	Date: 05 March 2015
	Purpose:
	-> Configures Keccak SHA-3 Signals before sending Input String. 
*/

class finish_ctrl_seq extends uvm_sequence#(sequence_item);
	`uvm_object_utils(finish_ctrl_seq)
	
	sequence_item command;
	
	function new(string name = "finish_ctrl_seq");
		super.new(name);
	endfunction: new

	task body();
		command = sequence_item::type_id::create("command");

		start_item(command);
		command.reset = 0;
		command.in_ready = 1;
		command.byte_num = 3;
		command.is_last = 1;
		finish_item(command);
		#20;
		start_item(command);
		command.reset = 0;
		command.is_last = 0;
		command.in_ready = 0;
		finish_item(command);

	endtask: body

endclass: finish_ctrl_seq
	