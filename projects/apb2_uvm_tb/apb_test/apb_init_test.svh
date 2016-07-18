//
// APB Initial Test to check environment
// Integrity and Basic Bus transaction checks
//
// Date: 27/03/2016
// Author: Mayur Kubavat
//

class apb_init_test extends apb_base_test;

    `uvm_component_utils(apb_init_test)

    reset_seq reset_seq_h;
    apb_rd_wr_seq apb_rd_wr_seq_h;

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
        apb_rd_wr_seq_h = apb_rd_wr_seq::type_id::create("apb_rd_wr_seq_h");

        phase.raise_objection(this);

        repeat(50)
        begin
            reset_seq_h.start(reset_seqr_h);
            repeat(3)
                apb_rd_wr_seq_h.start(m_bridge_seqr_h);
            reset_seq_h.start(reset_seqr_h);
            repeat(5)
                apb_rd_wr_seq_h.start(m_bridge_seqr_h);
        end
        #100;

        phase.drop_objection(this);

    endtask //run_phase

endclass //apb_init_test

