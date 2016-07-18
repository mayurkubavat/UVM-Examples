class tr1_test extends sha3_base_test;
	`uvm_component_utils(tr1_test)

	tr1_seq tr1_seq_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
   
	task run_phase(uvm_phase phase);
		tr1_seq_h = new("tr1_seq_h");
		phase.raise_objection(this);
		tr1_seq_h.start(null);
		phase.drop_objection(this);
	endtask : run_phase

endclass: tr1_test