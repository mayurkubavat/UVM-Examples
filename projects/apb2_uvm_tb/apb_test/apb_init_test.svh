// APB Initial Test to check environment
// Integrity and Basic Bus transaction checks

class apb_init_test extends apb_base_test;
  `uvm_component_utils(apb_init_test)

  reset_seq     reset_seq_h;
  apb_rd_wr_seq apb_rd_wr_seq_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    reset_seq_h     = reset_seq::type_id::create("reset_seq_h", this);
    apb_rd_wr_seq_h = apb_rd_wr_seq::type_id::create("apb_rd_wr_seq_h");

    phase.raise_objection(this);

    repeat(50) begin
      reset_seq_h.start(reset_seqr_h);
      repeat(3) begin
        apb_rd_wr_seq_h.start(m_bridge_seqr_h);
      end
      reset_seq_h.start(reset_seqr_h);
      repeat(5) begin
        apb_rd_wr_seq_h.start(m_bridge_seqr_h);
      end
    end
    #100;

    phase.drop_objection(this);
  endtask

endclass: apb_init_test

