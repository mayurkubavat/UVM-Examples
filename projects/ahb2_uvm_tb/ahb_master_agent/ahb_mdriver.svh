/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master Driver
 Filename: ahb_mdriver.svh
**********************************************************/

class ahb_mdriver extends uvm_driver#(ahb_mxtn);

   `uvm_component_utils(ahb_mdriver)

   virtual ahb_intf vif;
   ahb_magent_config magt_cfg;

   //------------------------------------------------
   // Methods
   //------------------------------------------------

   extern function new(string name = "ahb_mdriver", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task drive();

endclass: ahb_mdriver


function ahb_mdriver::new(string name = "ahb_mdriver", uvm_component parent);
   super.new(name, parent);
endfunction


function void ahb_mdriver::build_phase(uvm_phase phase);
   if(!uvm_config_db#(ahb_magent_config)::get(this, "", "ahb_magent_config", magt_cfg))
   begin
      `uvm_fatal(get_full_name(), "Cannot get VIF from configuration database!")
   end

   super.build_phase(phase);
endfunction


function void ahb_mdriver::connect_phase(uvm_phase phase);
   vif = magt_cfg.vif;
endfunction

  
task ahb_mdriver::run_phase(uvm_phase phase);
   fork

      // Continuously observe RESET and drive reset values on AHB interface
      // also cancel ongoing transaction by disabling driver() task
      forever
      begin
         wait(!vif.HRESETn);
         `uvm_info(get_type_name(), "RESET Detected..", UVM_MEDIUM)

         disable driver;

         vif.HTRANS <= 0;
         vif.HBURST <= 0;
         vif.HSIZE  <= 0;
         vif.HWRITE <= 0;
         vif.HADDR  <= 0;
         vif.HWDATA <= 0;

         wait(vif.HRESETn);
      end

      // Continuously observe non-IDLE HRESP and drive IDLE transaction on 2nd cycle of HRESP
      begin
         wait(vif.HRESETn);

         forever
         begin
            @(vif.mdrv_cb);

            // Detect 1st cycle of HRESP so as to drive HTRANS IDLE on 2nd cycle
            if((vif.HRESP != 2'b00) && (vif.HREADY == 0))
            begin
               `uvm_info("DRV", "Slave sent error/split/retry response, driving HTRANS == IDLE for 2nd cycle of HRESP", UVM_LOW)

               disable driver;

               vif.mdrv_cb.HTRANS <= 0;
            end
         end
      end
   join_none


   forever
   begin
      wait(vif.HRESETn);
      
      seq_item_port.get_next_item(req);

      // Populate BUSY states in HTRANS array
      void'(req.add_busy());

      begin: driver
         drive();
      end

      seq_item_port.item_done(req);
   end
endtask

//Drive
task ahb_mdriver::drive();
begin: drv

   int j;          //Variable to Increment HTRANS Queue
   bit busy_last;

      `uvm_info(get_type_name(), "Transaction From AHB Master Driver..", UVM_MEDIUM)
      req.print();

      //Drive Controls
      vif.mdrv_cb.HBURST <= req.burst_mode;
      vif.mdrv_cb.HSIZE <= req.trans_size;
      vif.mdrv_cb.HWRITE <= req.read_write;


      //Drive Address, Transaction Type and Data
      foreach(req.address[i])
      begin
         vif.mdrv_cb.HADDR <= req.address[i];
         if(busy_last)
         begin
                 @(vif.mdrv_cb);
                 busy_last = 0;
         end
         vif.mdrv_cb.HTRANS <= req.trans_type[j];
         if(req.trans_type[j] == 2'b01)
         begin
            do
            begin
               j++;
               @(vif.mdrv_cb);
               vif.mdrv_cb.HTRANS <= req.trans_type[j];
            end
            while(req.trans_type[j] == 2'b01);
         end
         @(vif.mdrv_cb);
         j++;

         while(!vif.mdrv_cb.HREADY) @(vif.mdrv_cb);
         if(req.read_write)
         begin
            vif.mdrv_cb.HWDATA <= req.write_data[i];
         end
      end
      if((req.burst_mode == INCR)&&(req.trans_type[j] == 1))
      begin
         vif.mdrv_cb.HTRANS <= 1'b1;     //Drive Busy at End
         busy_last = 1;
      end
end
endtask

