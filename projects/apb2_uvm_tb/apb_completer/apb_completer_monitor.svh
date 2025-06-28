class apb_completer_monitor extends uvm_monitor;
  `uvm_component_utils(apb_completer_monitor)

  virtual apb_if apb_intf;

  uvm_analysis_port#(apb_xtn) monitor_ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    monitor_ap = new("monitor_ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
  endtask

endclass
