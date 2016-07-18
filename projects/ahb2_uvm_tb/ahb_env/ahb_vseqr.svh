/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Virtual Sequencer
 Filename: ahb_vseqr.svh
**********************************************************/

class ahb_vseqr extends uvm_sequencer#(uvm_sequence_item);

        `uvm_component_utils(ahb_vseqr)


        reset_seqr reset_seqr_h;
        ahb_mseqr mseqr_h;
        ahb_sseqr sseqr_h;

        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "ahb_vseqr", uvm_component parent);

endclass: ahb_vseqr

        //Constructor
        function ahb_vseqr::new(string name = "ahb_vseqr", uvm_component parent);
                super.new(name, parent);
        endfunction

