/*****************************************************************
 * Filename: scoreboard.svh
 * Module Name: scoreboard
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date:___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Analysis FIFO for AHB & APB Monitors
 *  -> Configuration Object to Optionally Generate Coverage
 *  -> Self Checking for Data Operations
 *  -> Implements Functional Coverage Groups
 *  -> Statistics for Data Operation Comparisons
 * **************************************************************/

class scoreboard extends uvm_scoreboard;

	//Register to Factory
	`uvm_component_utils(scoreboard)

	//Configuration Object Handle and Property
	env_config cfg_h;

	bit has_coverage;

	//AHB & APB Transaction Handle
	ahb_xtn ahb_xtn_h;
	apb_xtn apb_xtn_h;

	//Analysis FIFO
	uvm_tlm_analysis_fifo#(ahb_xtn) fifo_ahb;
	uvm_tlm_analysis_fifo#(apb_xtn) fifo_apb;

	//Covergroup for AHB Transaction
	covergroup ahb_cov;
		option.per_instance = 1;
		
		ADDR: coverpoint ahb_xtn_h.HRESETn{bins h_addr[] = {0, 1};}
	endgroup
	
	//Covergroup for APB Transaction
	covergroup apb_cov;
		option.per_instance = 1;
		
		ADDR: coverpoint apb_xtn_h.PADDR{bins p_addr[] = {0, 1};}
	endgroup

	//------------------------------------------
	// Methods
	// -----------------------------------------
	extern function new(string name = "scoreboard", uvm_component parent);	
	extern function void build_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: scoreboard

//Constructor
function scoreboard::new(string name = "scoreboard", uvm_component parent);
	super.new(name, parent);

	//Create Analysis FIFOs
	fifo_ahb = new("fifo_ahb", this);
	fifo_apb = new("fifo_apb", this);
endfunction //new

function void scoreboard::build_phase(uvm_phase phase);
	//Get Configuration Object from Database
	if(!uvm_config_db#(env_config)::get(this, "", "env_config", cfg_h))
		`uvm_fatal("SCOREBOARD", "Cannot get Configuration Object from ENV")
	
	super.build_phase(phase);

	//Set Configuration Parameter from Configuration Object
	has_coverage = cfg_h.has_coverage;

endfunction //build_phase

function void scoreboard::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("SCOREBOARD", {get_full_name(), " Created.."}, UVM_MEDIUM)
endfunction //end_of_elaboration_phase
