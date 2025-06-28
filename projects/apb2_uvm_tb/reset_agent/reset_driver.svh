// Module: Reset Driver
// Filename: reset_driver.svh

class reset_driver extends uvm_driver#(reset_xtn);
  `uvm_component_utils(reset_driver)

  virtual apb_if vif;

  extern function new(string name = "reset_driver", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task reset();

endclass: reset_driver

function reset_driver::new(string name = "reset_driver", uvm_component parent);
  super.new(name, parent);
endfunction

function void reset_driver::build_phase(uvm_phase phase);
  if(!uvm_config_db#(virtual apb_if)::get(this, "", "reset_controller", vif)) begin
    `uvm_fatal(get_full_name(), "Cannot get VIF from configuration database!")
  end
  super.build_phase(phase);
endfunction

task reset_driver::run_phase(uvm_phase phase);
  forever begin
    seq_item_port.get_next_item(req);
    reset();
    seq_item_port.item_done(req);
  end
endtask

task reset_driver::reset();
  if(req.reset == 0) begin
    if(req.reset_assert) begin
      #10ns;
    end
    `uvm_info("RESET/DRV", "Driving RESET..", UVM_MEDIUM)
    vif.PRESETn <= 1'b0;

    repeat(req.reset_width) @(vif.mdrv_cb);

    vif.PRESETn <= 1'b1;
    @(vif.mdrv_cb);
  end
endtask

