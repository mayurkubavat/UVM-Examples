class apb_env_config extends uvm_object;
  `uvm_object_utils(apb_env_config)

  virtual apb_if apb_intf;

  uvm_active_passive_enum bridge_is_active = UVM_ACTIVE;
  uvm_active_passive_enum slave_is_active  = UVM_ACTIVE;

  bit has_coverage;

  function new(string name = "apb_env_config");
    super.new(name);
  endfunction

endclass: apb_env_config

