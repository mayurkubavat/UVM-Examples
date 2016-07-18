class tr1_seq extends base_sequence;
   `uvm_object_utils(tr1_seq);

	reset_seq s_reset;
	init_seq s_init;
	msg_seq s_msg;

	function new(string name = "tr1_seq");
		super.new(name);

		s_reset = reset_seq::type_id::create("s_reset");
		s_init = init_seq::type_id::create("s_init");
		s_msg = msg_seq::type_id::create("s_msg");
	endfunction : new

	task body();
		s_reset.start(sequencer_h);
		s_init.start(sequencer_h);
		s_msg.start(sequencer_h);
	endtask : body

endclass : tr1_seq