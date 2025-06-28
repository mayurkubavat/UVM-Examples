class apb_requester_driver extends uvm_driver#(apb_xtn);
  `uvm_component_utils(apb_requester_driver)

  virtual apb_if apb_intf;

  apb_requester_config bridge_cfg_h;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(apb_requester_config)::get(this, "", "apb_requester_config", bridge_cfg_h)) begin
      `uvm_fatal("APB/BRIDGE/DRV", "Cannot get VIF from configuration database!")
    end
    super.build_phase(phase);
  endfunction

  function void connect_phase(uvm_phase phase);
    apb_intf = bridge_cfg_h.apb_intf;
    super.connect_phase(phase);
  endfunction

  extern task drive();

  task run_phase(uvm_phase phase);
    fork
      // Detect RESET signals, Disable Driver on detection
      forever begin
        wait(!apb_intf.PRESETn);
        `uvm_info("APB/BRIDGE/DRV", "RESET assertion detected..", UVM_MEDIUM)
        disable driver;
        apb_intf.PADDR  <= 0;
        apb_intf.PPROT  <= 0;
        apb_intf.PENABLE <= 0;
        apb_intf.PWDATA <= 0;
        apb_intf.PSTRB  <= 0;

        wait(apb_intf.PRESETn);
        `uvm_info("APB/BRIDGE/DRV", "RESET deassertion detected..", UVM_MEDIUM)
      end

      forever begin
        seq_item_port.get_next_item(req);
        begin: driver
          wait(apb_intf.PRESETn);
          drive();
        end  // driver
        seq_item_port.item_done(req);
      end
    join
  endtask

endclass: apb_requester_driver

task apb_requester_driver::drive();
  `uvm_info("APB/BRIDGE/DRV", "Transaction From APB Master Driver..", UVM_MEDIUM)
  req.print();

  if(req.apb_rd_wr == apb_xtn::APB_READ)
    apb_intf.mdrv_cb.PWRITE <= 0;
  else begin
    apb_intf.mdrv_cb.PWRITE <= 1;
    apb_intf.mdrv_cb.PWDATA <= $random;
    apb_intf.mdrv_cb.PSTRB  <= $random;
  end

  apb_intf.mdrv_cb.PENABLE <= 1;
  apb_intf.mdrv_cb.PPROT  <= 1;
  apb_intf.mdrv_cb.PADDR  <= req.apb_address;

  wait(apb_intf.mdrv_cb.PENABLE && apb_intf.mdrv_cb.PREADY);
  apb_intf.mdrv_cb.PENABLE <= 0;

endtask
