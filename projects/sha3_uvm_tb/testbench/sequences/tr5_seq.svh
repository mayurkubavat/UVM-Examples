class tr5_seq extends base_sequence;
   `uvm_object_utils(tr5_seq);

	reset_seq s_reset;
	init_seq s_init;
	rndmsg_seq s_rmsg;

	function new(string name = "tr5_seq");
		super.new(name);

		s_reset = reset_seq::type_id::create("s_reset");
		s_init = init_seq::type_id::create("s_init");
		s_rmsg = rndmsg_seq::type_id::create("s_rmsg");
	endfunction : new

	task body();
		s_reset.start(sequencer_h);
		s_init.start(sequencer_h);
		s_rmsg.start(sequencer_h);
	endtask : body

endclass : tr5_seq