class apb_subscriber extends uvm_subscriber#(apb_xtn);
  `uvm_component_utils(apb_subscriber)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void write(apb_xtn t);
  endfunction

endclass: apb_subscriber
