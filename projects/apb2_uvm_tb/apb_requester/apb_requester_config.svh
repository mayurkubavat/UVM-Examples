class apb_requester_config extends uvm_object;
  `uvm_object_utils(apb_requester_config)

  virtual apb_if apb_intf;
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "apb_requester_config");
    super.new(name);
  endfunction

endclass: apb_requester_config
