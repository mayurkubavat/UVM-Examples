class init_seq extends uvm_sequence#(sequence_item);
	`uvm_object_utils(init_seq)
	
	sequence_item command;
	
	function new(string name = "init_seq");
		super.new(name);
	endfunction: new

	task body();
		command = sequence_item::type_id::create("command");
		start_item(command);
		command.reset = 0;
		command.in = 0;
		command.in_ready = 0;
		command.is_last = 0;
		command.byte_num = 0;
		finish_item(command);
		#30;
	endtask: body

endclass: init_seq