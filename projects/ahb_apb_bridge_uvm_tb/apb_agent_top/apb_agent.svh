/*****************************************************************
 * Filename: apb_agent.svh
 * Class Name: apb_agent
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Handle for APB Driver and Monitor
 * **************************************************************/

class apb_agent extends uvm_agent;

	//Factory Registration Macro
	`uvm_component_utils(apb_agent)

	//APB Driver and Monitor Handles
	apb_driver apb_driver_h;
	apb_monitor apb_monitor_h;

	//----------------------------------------
	// Methods
	// ---------------------------------------
	extern function new(string name = "apb_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: apb_agent

//Constructor
function apb_agent::new(string name = "apb_agent", uvm_component parent);
	super.new(name, parent);
endfunction //new

//Build Phase
function void apb_agent::build_phase(uvm_phase phase);

	super.build_phase(phase);

	//Create APB Driver
	apb_driver_h = apb_driver::type_id::create("apb_driver_h", this);
	//Create APB Monitor
	apb_monitor_h = apb_monitor::type_id::create("apb_monitor_h", this);

endfunction //build_phase

//Connect Phase
function void apb_agent::connect_phase(uvm_phase phase);

endfunction //connect_phase

//End of Elaboration Phase
function void apb_agent::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("APB_AGENT", {get_full_name(), " Created.."}, UVM_MEDIUM)
endfunction //end_of_elaboration_phase
