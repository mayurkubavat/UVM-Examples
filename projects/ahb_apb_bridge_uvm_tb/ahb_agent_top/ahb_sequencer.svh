/*****************************************************************
 * Filename: ahb_sequencer.svh
 * Class Name: ahb_sequencer
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> uvm_sequencer parameterized with AHB Transaction Type
 * **************************************************************/

class ahb_sequencer extends uvm_sequencer#(ahb_xtn);

	`uvm_component_utils(ahb_sequencer)

	//Constructor
	function new(string name = "ahb_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

endclass: ahb_sequencer
