class apb_seqr extends uvm_sequencer#(apb_xtn);
  `uvm_component_utils(apb_seqr)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass: apb_seqr
