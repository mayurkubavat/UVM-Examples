/*****************************************************************
 * Filename: ahb_seqs.svh
 * Class Name:
 * Author: Mayur
 * Creation Date: 7 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Base Test and Extended Tests
 * **************************************************************/

class ahb_base_seq extends uvm_sequence#(ahb_xtn);

	//Register with Factory
	`uvm_object_utils(ahb_base_seq)

	//------------------------------------------------
	// Methods
	// -----------------------------------------------
	extern function new(string name = "ahb_base_seq");

endclass: ahb_base_seq

//Base Constructor
function ahb_base_seq::new(string name = "ahb_base_seq");
	super.new(name);
endfunction


//-----------------------------------------------------------------
// AHB Reset Sequence
//-----------------------------------------------------------------
class ahb_reset_seq extends ahb_base_seq;

	//Register with Factory
	`uvm_object_utils(ahb_reset_seq)

	//------------------------------------------------
	// Methods
	// -----------------------------------------------
	extern function new(string name = "ahb_reset_seq");
	extern task body();

endclass: ahb_reset_seq

//Constructor
function ahb_reset_seq::new(string name = "ahb_reset_seq");
	super.new(name);
endfunction

task ahb_reset_seq::body();

	req = ahb_xtn::type_id::create("req");
	start_item(req);
	assert(req.randomize());
	req.HRESETn = 0;
	finish_item(req);

endtask //body

