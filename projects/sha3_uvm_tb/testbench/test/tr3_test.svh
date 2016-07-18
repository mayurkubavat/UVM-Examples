class tr3_test extends sha3_base_test;
	`uvm_component_utils(tr3_test)

	tr3_seq tr3_seq_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
   
	task run_phase(uvm_phase phase);
		tr3_seq_h = new("tr3_seq_h");
		phase.raise_objection(this);
		tr3_seq_h.start(null);
		phase.drop_objection(this);
	endtask : run_phase

endclass: tr3_test