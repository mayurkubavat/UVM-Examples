// APB test to check dynamic reset behaviour

class apb_reset_test extends apb_base_test;
  `uvm_component_utils(apb_reset_test)

  reset_seq reset_seq_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    reset_seq_h = reset_seq::type_id::create("reset_seq_h", this);

    phase.raise_objection(this);

    repeat(100)
      reset_seq_h.start(reset_seqr_h);

    phase.drop_objection(this);
  endtask

endclass: apb_reset_test

