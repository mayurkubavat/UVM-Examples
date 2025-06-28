// Module: APB Sequence
// Filename: apb_requester_seqs.svh

class apb_base_seq extends uvm_sequence#(apb_xtn);
  `uvm_object_utils(apb_base_seq)

  extern function new(string name = "apb_base_seq");

endclass: apb_base_seq

function apb_base_seq::new(string name = "apb_base_seq");
  super.new(name);
endfunction

class apb_rd_wr_seq extends apb_base_seq;
  `uvm_object_utils(apb_rd_wr_seq)

  extern function new(string name = "apb_rd_wr_seq");
  extern task body();

endclass: apb_rd_wr_seq

function apb_rd_wr_seq::new(string name = "apb_rd_wr_seq");
  super.new(name);
endfunction

task apb_rd_wr_seq::body();
  req = apb_xtn::type_id::create("req");
  start_item(req);
  assert(req.randomize());
  finish_item(req);
endtask

