/*
	Description: Base Test in UVM environment. It is virtual class,
	So, sha3_base_test must me extended to implement various test.
	Author: Mayur Kubavat
	Date: 28 Feb 2015
	Purpose:
	-> Extends uvm_test base class,
	-> Instantiate Env and Sequencer,
	-> Build Env.
*/

virtual class sha3_base_test extends uvm_test;
	
	sha3_env env_h;
	sequencer sequencer_h;
	
	function void build_phase(uvm_phase phase);
		env_h = sha3_env::type_id::create("env_h", this);
	endfunction: build_phase

	function void end_of_elaboration_phase(uvm_phase phase);
		sequencer_h = env_h.agent.sequencer_h;
		print();
	endfunction: end_of_elaboration_phase

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
endclass: sha3_base_test