class apb_completer_config extends uvm_object;
  `uvm_object_utils(apb_completer_config)

  virtual apb_if apb_intf;
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "apb_completer_config");
    super.new(name);
  endfunction

endclass
