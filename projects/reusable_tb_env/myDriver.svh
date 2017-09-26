class myDriver extends uvm_driver#(myTransaction);
   `uvm_component_utils(myDriver)

   virtual myInterface vif;

   inpInterface inpInterfaceH;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void connect_phase(uvm_phase phase);
      if(!uvm_config_db#(virtual myInterface)::get(this, "", "vif", vif))
         `uvm_fatal("NOVIF", "Virtual Interface not Found!")
   endfunction

   task run_phase(uvm_phase phase);
      forever
      begin
         seq_item_port.get_next_item(req);
            fork
               drive();
            join_none
         seq_item_port.item_done(req);
      end
   endtask

   task drive();
      case(req.baseInterfaceH.get_type_name())
         "inpInterface":
            begin
               $cast(inpInterfaceH, req.baseInterfaceH);
               @(vif.drvCb) vif.drvCb.inp <= inpInterfaceH.inp;
            end
         default: ;
      endcase
   endtask
endclass
