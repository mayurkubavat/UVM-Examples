/*****************************************************************
 * Filename: env_config.svh
 * Class Name: env_config
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Configuration Properties.
 *  e.g. AHB, APB Virtual Interface, has_scoreboard etc.
 * **************************************************************/

class env_config extends uvm_object;

	//Register with Factory
	`uvm_object_utils(env_config)

	//Configuration Properties
	bit has_scoreboard;
	bit has_vsequencer;
	bit has_coverage;

	ahb_agent_config ahb_cfg_h;
	apb_agent_config apb_cfg_h;

	//Virtual Interface Handle
	virtual ahb_if ahb_vif;
	virtual apb_if apb_vif;

	//Constructor
	function new(string name = "env_config");
		super.new(name);
	endfunction

endclass: env_config
