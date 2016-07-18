/*****************************************************************
 * Filename: vsequencer.sv
 * Class Name: vsequencer
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Handle for ahb_sequencer
 *  -> Used to Create Abstraction for ahb_sequencer Access
 * **************************************************************/

class vsequencer extends uvm_sequencer#(ahb_xtn);

	//Register with Factory
	`uvm_component_utils(vsequencer)

	//AHB Sequencer Handle
	ahb_sequencer ahb_sequencer_h;

	//Constructor
	function new(string name = "vsequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

endclass: vsequencer

