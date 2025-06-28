// Module: Reset Sequence
// Filename: reset_seq.svh

class reset_base_seq extends uvm_sequence#(reset_xtn);
  `uvm_object_utils(reset_base_seq)

  extern function new(string name = "reset_base_seq");

endclass: reset_base_seq

function reset_base_seq::new(string name = "reset_base_seq");
  super.new(name);
endfunction

// Reset sequence - Configure reset assertion and deassertion time
class reset_seq extends reset_base_seq;
  `uvm_object_utils(reset_seq)

  extern function new(string name = "reset_seq");
  extern task body();

endclass: reset_seq

function reset_seq::new(string name = "reset_seq");
  super.new(name);
endfunction

task reset_seq::body();
  req = reset_xtn::type_id::create("req");
  start_item(req);
  req.reset        = 0;
  req.reset_assert = {$urandom} % 10;
  req.reset_width  = 5;
  finish_item(req);
endtask
