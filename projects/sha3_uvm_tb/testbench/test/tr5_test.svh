class tr5_test extends sha3_base_test;
	`uvm_component_utils(tr5_test)

	tr5_seq tr5_seq_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
   
	task run_phase(uvm_phase phase);
		tr5_seq_h = new("tr5_seq_h");
		phase.raise_objection(this);
		tr5_seq_h.start(null);
		phase.drop_objection(this);
	endtask : run_phase

endclass: tr5_test