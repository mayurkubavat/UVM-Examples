class msg_seq extends uvm_sequence#(sequence_item);
	`uvm_object_utils(msg_seq)
	
	sequence_item command;
	
	function new(string name = "msg_seq");
		super.new(name);
	endfunction: new

	task body();
		command = sequence_item::type_id::create("command");
		
		for(command.i = 0; command.i < 11; command.i++) begin
		//assert(command.randomize());
		
		start_item(command);
		
		command.byte_num = 0;
		command.reset = 0;
		command.in_ready = 1;
		command.is_last = 0;
		
		command.in = command.golden_message[command.i];
		$display("%d th Message is: %s", command.i, command.golden_message[command.i]);
		finish_item(command);
		if(command.i == 10) break;
		#20;
		end
		
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
		#1000;
		
	endtask: body

endclass: msg_seq