/**********************************************************
 start date: 11 sept 2015
 finish date: 22 sept 2015
 author: mayur kubavat
 
 module: ahb test 
 filename: ahb_wrapx_test.svh
**********************************************************/

class ahb_wrapx_test extends ahb_base_test;

        `uvm_component_utils(ahb_wrapx_test)

        //----------------------------------------------------
        // Methods
        //----------------------------------------------------

        extern function new(string name = "ahb_wrapx_test", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

endclass: ahb_wrapx_test

//Constructor
function ahb_wrapx_test::new(string name = "ahb_wrapx_test", uvm_component parent);
        super.new(name, parent);
endfunction

//Build
function void ahb_wrapx_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction

//Run
task ahb_wrapx_test::run_phase(uvm_phase phase);
        reset_vseq_h = ahb_reset_vseq::type_id::create("reset_vseq_h", this);
        set_vseq_h = ahb_set_vseq::type_id::create("set_vseq_h", this);
        wrapx_vseq_h = ahb_wrapx_vseq::type_id::create("wrapx_vseq_h", this);
        ready_vseq_h = ahb_ready_vseq::type_id::create("ready_vseq_h", this);
        idle_vseq_h = ahb_idle_vseq::type_id::create("idle_vseq_h", this);
        phase.raise_objection(this);

                fork
                        reset_vseq_h.start(env_h.vseqr_h);
                        reset_vseq_h.start(env_h.vseqr_h);
                        reset_vseq_h.start(env_h.vseqr_h);
                        reset_vseq_h.start(env_h.vseqr_h);
                        set_vseq_h.start(env_h.vseqr_h);
                join_none

                repeat(10)
                begin
                        fork
                                ready_vseq_h.start(env_h.vseqr_h);
                        join_none
                        wrapx_vseq_h.start(env_h.vseqr_h);
                end

                idle_vseq_h.start(env_h.vseqr_h);

                #100;
        phase.drop_objection(this);
endtask

