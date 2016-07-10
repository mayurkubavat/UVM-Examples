/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Test 
 Filename: ahb_reset_test.svh
**********************************************************/

class ahb_reset_test extends ahb_base_test;

        `uvm_component_utils(ahb_reset_test)

        //----------------------------------------------------
        // Methods
        //----------------------------------------------------

        extern function new(string name = "ahb_reset_test", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass: ahb_reset_test

//Constructor
function ahb_reset_test::new(string name = "ahb_reset_test", uvm_component parent);
        super.new(name, parent);
endfunction

//Build
function void ahb_reset_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

//Run
task ahb_reset_test::run_phase(uvm_phase phase);
        reset_vseq_h = ahb_reset_vseq::type_id::create("reset_vseq_h", this);
        phase.raise_objection(this);
                reset_vseq_h.start(env_h.vseqr_h);
        phase.drop_objection(this);
endtask

