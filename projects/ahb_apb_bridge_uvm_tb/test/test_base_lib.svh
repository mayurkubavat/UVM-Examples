/*****************************************************************
 * Filename: test_base_lib.svh
 * Class Name:
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Base Test and Extended Tests
 * **************************************************************/

class base_test extends uvm_test;

	//Register with Factory
	`uvm_component_utils(base_test)

	//Environment Handle
	env env_h;
	
	bit has_scoreboard;
	bit has_vsequencer;
	bit has_coverage;

	//Virtual Sequence Handles
	reset_vseq reset_vseq_h;

	//Env Configuration Object Handle
	env_config cfg_h;

	//--------------------------------------------
	// Methods
	// -------------------------------------------
	extern function new(string name = "base_test", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: base_test

//Base Test Constructor
function base_test::new(string name = "base_test", uvm_component parent);
	super.new(name, parent);
endfunction //new

//Base Test Build Phase
function void base_test::build_phase(uvm_phase phase);
	
	//Create Env Configuration Object from TOP
	cfg_h = env_config::type_id::create("cfg_h");

	//Get AHB Virtual Interface from TOP
	if(!uvm_config_db#(virtual ahb_if)::get(this, "", "ahb_vif", cfg_h.ahb_vif))
		`uvm_fatal("BASE_TEST", "Cannot get AHB Virtual Interface from TOP")
	if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_vif", cfg_h.apb_vif))
		`uvm_fatal("BASE_TEST", "Cannot get APB Virtual Interface from TOP")


	has_scoreboard = 1;
	has_vsequencer = 1;
	has_coverage = 1;
	
	cfg_h.has_scoreboard = has_scoreboard;
	cfg_h.has_vsequencer = has_vsequencer;
	cfg_h.has_coverage = has_coverage;

	//Set Env Configuration Object
	uvm_config_db#(env_config)::set(this, "*", "env_config", cfg_h);

	//Create Env
	env_h = env::type_id::create("env_h", this);

endfunction //build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
	print();
endfunction //end_of_elaboration_phase


//----------------------------------------------------------------------------------------
// Reset Test
// ---------------------------------------------------------------------------------------
class reset_test extends base_test;

	//Register with Factory
	`uvm_component_utils(reset_test)

	reset_vseq reset_h;

	//----------------------------------------
	// Methods
	// ---------------------------------------
	extern function new(string name = "reset_test", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass: reset_test

//Constructor
function reset_test::new(string name = "reset_test", uvm_component parent);
	super.new(name, parent);
endfunction

//Build Phase
function void reset_test::build_phase(uvm_phase phase);
	

	super.build_phase(phase);

endfunction

//End of Elaboration Phase
function void reset_test::end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
endfunction

//Run Phase
task reset_test::run_phase(uvm_phase phase);

	phase.raise_objection(this);
	
		reset_vseq_h = reset_vseq::type_id::create("reset_vseq_h");
		reset_vseq_h.start(env_h.vsequencer_h);

	phase.drop_objection(this);

endtask //reset_test run_phase
