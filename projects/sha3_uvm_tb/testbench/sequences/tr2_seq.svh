class tr2_seq extends base_sequence;
   `uvm_object_utils(tr2_seq);

	reset_seq s_reset;
	init_seq s_init;
	long_msg_seq s_lmsg;

	function new(string name = "tr2_seq");
		super.new(name);
 
		s_reset = reset_seq::type_id::create("s_reset");
		s_init = init_seq::type_id::create("s_init");
		s_lmsg = long_msg_seq::type_id::create("s_lmsg");
	endfunction : new

	task body();
		s_reset.start(sequencer_h);
		s_init.start(sequencer_h);
		s_lmsg.start(sequencer_h);
	endtask : body

endclass : tr2_seq