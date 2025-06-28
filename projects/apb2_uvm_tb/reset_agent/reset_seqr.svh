// Module: Reset Sequencer
// Filename: reset_seqr.svh

class reset_seqr extends uvm_sequencer#(reset_xtn);
  `uvm_component_utils(reset_seqr)

  extern function new(string name = "reset_seqr", uvm_component parent);

endclass: reset_seqr

function reset_seqr::new(string name = "reset_seqr", uvm_component parent);
  super.new(name, parent);
endfunction

