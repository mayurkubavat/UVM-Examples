/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master Sequencer
 Filename: ahb_mseqr.svh
**********************************************************/

class ahb_mseqr extends uvm_sequencer#(ahb_mxtn);

        `uvm_component_utils(ahb_mseqr)


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_mseqr", uvm_component parent);

endclass: ahb_mseqr

        //Constructor
        function ahb_mseqr::new(string name = "ahb_mseqr", uvm_component parent);
                super.new(name, parent);
        endfunction


