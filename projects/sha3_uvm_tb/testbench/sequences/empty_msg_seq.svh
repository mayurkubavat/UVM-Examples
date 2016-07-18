class empty_msg_seq extends uvm_sequence#(sequence_item);
	`uvm_object_utils(empty_msg_seq)
	
	sequence_item command;
	
	function new(string name = "empty_msg_seq");
		super.new(name);
	endfunction: new

	task body();
		command = sequence_item::type_id::create("command");

		start_item(command);
		
		command.byte_num = 0;
		command.reset = 0;
		command.in_ready = 1;
		command.is_last = 0;
		
		command.in = "";
		
		finish_item(command);
		#20;
		start_item(command);
		command.reset = 0;
		command.in_ready = 1;
		command.byte_num = 0;
		command.is_last = 1;
		finish_item(command);
		#20;
		start_item(command);
		command.reset = 0;
		command.is_last = 0;
		command.in_ready = 0;
		finish_item(command);
		#1000;
		
	endtask: body

endclass: empty_msg_seq