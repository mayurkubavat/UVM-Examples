//
// APB test to check dynamic reset behaviour
//
// Date: 16/07/2016
// Author: Mayur Kubavat
//

class apb_reset_test extends apb_base_test;

    `uvm_component_utils(apb_reset_test)

    reset_seq reset_seq_h;

    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    //Build
    function void buil_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction //build_phase

    task run_phase(uvm_phase phase);

        reset_seq_h = reset_seq::type_id::create("reset_seq_h", this);

        phase.raise_objection(this);

        repeat(100)
            reset_seq_h.start(reset_seqr_h);

        phase.drop_objection(this);

    endtask //run_phase

endclass //apb_reset_test

