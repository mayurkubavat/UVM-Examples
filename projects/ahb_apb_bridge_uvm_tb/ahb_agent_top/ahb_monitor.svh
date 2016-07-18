/*****************************************************************
 * Filename: ahb_monitor.svh
 * Class Name: ahb_monitor
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Get Virtual Interface from ENV Configuration
 *  -> Collect AHB Transaction on to AHB-APB Bridge
 * **************************************************************/

class ahb_monitor extends uvm_monitor;

	//Factory Registration
	`uvm_component_utils(ahb_monitor)

	//Agent Configuration Object
	ahb_agent_config cfg_h;

	//Analysis Port
	uvm_analysis_port#(ahb_xtn) monitor_ap;

	//Virtual Interface Handle
	virtual ahb_if.MON_MP vif;

	//APB Transaction Handle
	ahb_xtn xtn;

	//----------------------------------------------
	// Methods
	// ---------------------------------------------
	extern function new(string name = "ahb_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: ahb_monitor

//Constructor
function ahb_monitor::new(string name = "ahb_monitor", uvm_component parent);
	super.new(name, parent);
	monitor_ap = new("monitor_ap", this);
endfunction //new

//Build Phase
function void ahb_monitor::build_phase(uvm_phase phase);
	//Get Configuration Object from AHB Agent
	if(!uvm_config_db#(ahb_agent_config)::get(this, "", "ahb_agent_config", cfg_h))
		`uvm_fatal("AHB_MONITOR", "Cannot get vif from AHB Agent")

	super.build_phase(phase);
endfunction //build_phase

//Connect Phase
function void ahb_monitor::connect_phase(uvm_phase phase);
	vif = cfg_h.vif;
endfunction //connect_phase

//End of Elaboration Phase
function void ahb_monitor::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_MONITOR", {get_full_name(), " Created.."}, UVM_MEDIUM);
endfunction //end_of_elaboration

