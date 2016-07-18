class tr3_seq extends base_sequence;
   `uvm_object_utils(tr3_seq);

	reset_seq s_reset;
	init_seq s_init;
	empty_msg_seq s_empty_msg;
	
	function new(string name = "tr3_seq");
		super.new(name);
		
		s_reset = reset_seq::type_id::create("s_reset");
		s_init = init_seq::type_id::create("s_init");
		s_empty_msg = empty_msg_seq::type_id::create("s_empty_msg");
	endfunction : new

	task body();
		s_reset.start(sequencer_h);
		s_init.start(sequencer_h);
		s_empty_msg.start(sequencer_h);
	endtask : body

endclass : tr3_seq