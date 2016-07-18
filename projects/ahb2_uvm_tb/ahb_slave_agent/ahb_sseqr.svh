/**********************************************************
 Start Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Slave Sequencer
 Filename: ahb_sseqr.svh
**********************************************************/

class ahb_sseqr extends uvm_sequencer#(ahb_sxtn);

        `uvm_component_utils(ahb_sseqr)


        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "ahb_sseqr", uvm_component parent);

endclass: ahb_sseqr

        //Constructor
        function ahb_sseqr::new(string name = "ahb_sseqr", uvm_component parent);
                super.new(name, parent);
        endfunction

