/*****************************************************************
 * Filename: ahb_agent_config.svh
 * Class Name: ahb_agent_config
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Has Virtual Interface Property
 * **************************************************************/

class ahb_agent_config extends uvm_object;

	`uvm_object_utils(ahb_agent_config)

	virtual ahb_if vif;

	//Constructor
	function new(string name = "ahb_agent_config");
		super.new(name);
	endfunction

endclass: ahb_agent_config
