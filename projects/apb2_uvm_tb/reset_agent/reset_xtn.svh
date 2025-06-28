class reset_xtn extends uvm_sequence_item;
  // Reset signal when Low, asserts reset after assertion time,
  // for the time duration(ns) of reset width(CLK Cycle)
  bit          reset;
  int unsigned reset_assert;
  int unsigned reset_width;

  `uvm_object_utils_begin(reset_xtn)
    `uvm_field_int(reset, UVM_DEFAULT)
    `uvm_field_int(reset_assert, UVM_DEFAULT)
    `uvm_field_int(reset_width, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "reset_xtn");
    super.new(name);
  endfunction

endclass: reset_xtn
