/**********************************************************
 Start Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Slave Driver
 Filename: ahb_sdriver.svh
**********************************************************/

class ahb_sdriver extends uvm_driver#(ahb_sxtn);

   `uvm_component_utils(ahb_sdriver)

   virtual ahb_intf.SDRV_MP vif;
   ahb_sagent_config sagt_cfg;


   //------------------------------------------------
   // Methods
   //------------------------------------------------

   extern function new(string name = "ahb_sdriver", uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
   extern task drive();
   extern task reset_();

endclass: ahb_sdriver

function ahb_sdriver::new(string name = "ahb_sdriver", uvm_component parent);
   super.new(name, parent);
endfunction

function void ahb_sdriver::build_phase(uvm_phase phase);
   if(!uvm_config_db#(ahb_sagent_config)::get(this, "", "ahb_sagent_config", sagt_cfg))
   begin
      `uvm_fatal(get_full_name(), "Cannot get VIF from configuration databse!")
   end

   super.build_phase(phase);
endfunction

function void ahb_sdriver::connect_phase(uvm_phase phase);
   vif = sagt_cfg.vif;
endfunction

task ahb_sdriver::run_phase(uvm_phase phase);
   forever
   begin
      seq_item_port.get_next_item(req);
      fork
         begin: drv
            drive();
            disable rst;
         end
         begin:rst
            reset_();
            disable drv;
         end
      join
      seq_item_port.item_done(req);
   end
endtask

task ahb_sdriver::drive();
begin: driver
   if(req.response == ERROR)
   begin
      vif.sdrv_cb.HRESP  <= 1;
      vif.sdrv_cb.HREADY <= 0;

      @(vif.sdrv_cb);
      vif.sdrv_cb.HREADY <= 1;

      @(vif.sdrv_cb);
   end
   else
   begin
      vif.sdrv_cb.HRESP <= 0;

      foreach(req.ready[i])
      begin
         vif.sdrv_cb.HREADY <= req.ready[i];

         if((vif.sdrv_cb.HREADY)&&(!vif.sdrv_cb.HWRITE)&&(vif.sdrv_cb.HTRANS != 0)&&(vif.sdrv_cb.HTRANS != 1))
            vif.sdrv_cb.HRDATA <= {$random};

         if(vif.sdrv_cb.HSIZE > 2)
            vif.sdrv_cb.HRESP <= 1;
         else 
            vif.sdrv_cb.HRESP <= 0;

         @(vif.sdrv_cb);
      end
      vif.sdrv_cb.HREADY <= 1'b1;
   end
end: driver
endtask

task ahb_sdriver::reset_();
   wait(!vif.HRESETn);

   vif.sdrv_cb.HRESP  <= 0;
   vif.sdrv_cb.HREADY <= 1;
   vif.sdrv_cb.HRDATA <= 0;

   @(vif.sdrv_cb);
endtask

