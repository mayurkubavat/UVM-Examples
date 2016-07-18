/*****************************************************************
 * Filename: apb_agent_config.svh
 * Class Name: apb_agent_config
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Has Virtual Interface Property
 * **************************************************************/

class apb_agent_config extends uvm_object;

	`uvm_object_utils(apb_agent_config)

	virtual apb_if vif;

	//Constructor
	function new(string name = "apb_agent_config");
		super.new(name);
	endfunction

endclass: apb_agent_config
