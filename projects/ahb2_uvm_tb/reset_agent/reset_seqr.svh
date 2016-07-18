/**********************************************************
 Start Date: 22 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: Reset Sequencer
 Filename: reset_seqr.svh
**********************************************************/

class reset_seqr extends uvm_sequencer#(ahb_mxtn);

        `uvm_component_utils(reset_seqr)


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "reset_seqr", uvm_component parent);

endclass: reset_seqr

        //Constructor
        function reset_seqr::new(string name = "reset_seqr", uvm_component parent);
                super.new(name, parent);
        endfunction

