/*****************************************************************
 * Filename: ahb_agent.svh
 * Class Name: ahb_agent
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Handle for AHB Driver, Monitor and Sequencer
 *  -> Connects AHB Sequencer seq_item_export to AHB Driver 
 *  seq_item_port
 * **************************************************************/

class ahb_agent extends uvm_agent;

	//Factory Registration Macro
	`uvm_component_utils(ahb_agent)

	//AHB Sequencer, Driver and Monitor Handles
	ahb_sequencer ahb_sequencer_h;
	ahb_driver ahb_driver_h;
	ahb_monitor ahb_monitor_h;

	//----------------------------------------
	// Methods
	// ---------------------------------------
	extern function new(string name = "ahb_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: ahb_agent

//Constructor
function ahb_agent::new(string name = "ahb_agent", uvm_component parent);
	super.new(name, parent);
endfunction //new

//Build Phase
function void ahb_agent::build_phase(uvm_phase phase);

	super.build_phase(phase);

	//Create AHB Driver
	ahb_driver_h = ahb_driver::type_id::create("ahb_driver_h", this);
	//Create AHB Sequencer
	ahb_sequencer_h = ahb_sequencer::type_id::create("ahb_sequencer_h", this);
	//Create AHB Monitor
	ahb_monitor_h = ahb_monitor::type_id::create("ahb_monitor_h", this);

endfunction //build_phase

//Connect Phase
function void ahb_agent::connect_phase(uvm_phase phase);

	//Connect Driver seq_item_port to Sequencer seq_item_export
	ahb_driver_h.seq_item_port.connect(ahb_sequencer_h.seq_item_export);

endfunction //connect_phase

//End of Elaboration Phase
function void ahb_agent::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_AGENT", {get_full_name(), " Created.."}, UVM_MEDIUM)
endfunction //end_of_elaboration_phase
