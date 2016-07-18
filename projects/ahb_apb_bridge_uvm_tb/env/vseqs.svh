/*****************************************************************
 * Filename: vseqs.svh
 * Class Name:
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Base and Extended Virtual Sequence.
 * **************************************************************/

class base_vseq extends uvm_sequence#(uvm_sequence_item);

	//Register with Factory
	`uvm_object_utils(base_vseq)
	
	//Virtual Sequencer Handle
	vsequencer vsequencer_h;

	//AHB Sequencer Handle
	ahb_sequencer ahb_sequencer_h;

	//AHB Sequence Handles
	ahb_reset_seq ahb_reset_seq_h;

	//------------------------------------------------
	// Methods
	// -----------------------------------------------
	extern function new(string name = "base_vseq");
	extern task body();

endclass: base_vseq

//Base Constructor
function base_vseq::new(string name = "base_vseq");
	super.new(name);
endfunction

//Base Body
task base_vseq::body();

	if(!$cast(vsequencer_h, m_sequencer))
	begin
		`uvm_fatal("BASE_VSEQ", "Virtual Sequencer Cast Failed")
	end

	ahb_sequencer_h = vsequencer_h.ahb_sequencer_h;

endtask //base body


//-----------------------------------------------------------------------
// Reset Virtual Sequence
// ----------------------------------------------------------------------
class reset_vseq extends base_vseq;

	//Factory Registration
	`uvm_object_utils(reset_vseq)

	//------------------------------------------------
	// Methods
	// -----------------------------------------------
	extern function new(string name = "reset_vseq");
	extern task body();

endclass: reset_vseq

//Reset Vseq Constructor
function reset_vseq::new(string name = "reset_vseq");
	super.new(name);
endfunction

//Reset Vseq Body
task reset_vseq::body();

	ahb_reset_seq_h = ahb_reset_seq::type_id::create("ahb_reset_seq_h");
	ahb_reset_seq_h.start(ahb_sequencer_h);

endtask //reset vseq body

