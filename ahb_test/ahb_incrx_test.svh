/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Test 
 Filename: ahb_incrx_test.svh
**********************************************************/

class ahb_incrx_test extends ahb_base_test;

        `uvm_component_utils(ahb_incrx_test)

        //----------------------------------------------------
        // Methods
        //----------------------------------------------------

        extern function new(string name = "ahb_incrx_test", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass: ahb_incrx_test

//Constructor
function ahb_incrx_test::new(string name = "ahb_incrx_test", uvm_component parent);
        super.new(name, parent);
endfunction

//Build
function void ahb_incrx_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

//Run
task ahb_incrx_test::run_phase(uvm_phase phase);
        reset_vseq_h = ahb_reset_vseq::type_id::create("reset_vseq_h", this);
        set_vseq_h = ahb_set_vseq::type_id::create("set_vseq_h", this);
        incrx_vseq_h = ahb_incrx_vseq::type_id::create("incrx_vseq_h", this);
        ready_vseq_h = ahb_ready_vseq::type_id::create("ready_vseq_h", this);
        idle_vseq_h = ahb_idle_vseq::type_id::create("idle_vseq_h", this);
        phase.raise_objection(this);

                fork
                //      repeat(5)
                                reset_vseq_h.start(env_h.vseqr_h);
                        set_vseq_h.start(env_h.vseqr_h);
                join_none

                repeat(10)
                begin
                        fork
                                ready_vseq_h.start(env_h.vseqr_h);
                        join_none

                        incrx_vseq_h.start(env_h.vseqr_h);
                end

                idle_vseq_h.start(env_h.vseqr_h);
                #100;
        phase.drop_objection(this);
endtask

