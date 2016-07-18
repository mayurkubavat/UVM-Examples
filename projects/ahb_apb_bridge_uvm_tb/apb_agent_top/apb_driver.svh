/*****************************************************************
 * Filename: apb_driver.svh
 * Class Name: apb_driver
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Get Virtual Interface from ENV Configuration
 *  -> Drive APB Transaction on to AHB-APB Bridge
 * **************************************************************/

class apb_driver extends uvm_driver#(apb_xtn);

	//Factory Registration
	`uvm_component_utils(apb_driver)

	//Agent Configuration Object
	apb_agent_config cfg_h;

	//Virtual Interface Handle
	virtual apb_if.DRV_MP vif;

	//APB Transaction Handle
	apb_xtn xtn;

	//----------------------------------------------
	// Methods
	// ---------------------------------------------
	extern function new(string name = "apb_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: apb_driver

//Constructor
function apb_driver::new(string name = "apb_driver", uvm_component parent);
	super.new(name, parent);
endfunction //new

//Build Phase
function void apb_driver::build_phase(uvm_phase phase);
	//Get Configuration Object from AHB Agent
	if(!uvm_config_db#(apb_agent_config)::get(this, "", "apb_agent_config", cfg_h))
		`uvm_fatal("APB_DRIVER", "Cannot get vif from AHB Agent")

	super.build_phase(phase);
endfunction //build_phase

//Connect Phase
function void apb_driver::connect_phase(uvm_phase phase);
	vif = cfg_h.vif;
endfunction //connect_phase

//End of Elaboration Phase
function void apb_driver::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("APB_DRIVER", {get_full_name(), " Created.."}, UVM_MEDIUM);
endfunction //end_of_elaboration

