class tr2_test extends sha3_base_test;
	`uvm_component_utils(tr2_test)

	tr2_seq tr2_seq_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
   
	task run_phase(uvm_phase phase);
		tr2_seq_h = new("tr2_seq_h");
		phase.raise_objection(this);
		tr2_seq_h.start(null);
		phase.drop_objection(this);
	endtask : run_phase

endclass: tr2_test