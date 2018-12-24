class my_component extends uvm_component;
   `uvm_component_utils(my_component)

   // Objection to monitor heartbeat of this component
   uvm_objection hb_objection;

   virtual my_interface my_vif;


   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction


   function void connect_phase(uvm_phase phase);
      // Getting HB Objection
      if(!uvm_config_db#(uvm_objection)::get(this, "", "hb_objection", hb_objection))
         `uvm_fatal("NOHBOBJ", "Cannot find Hearbeat Objection setting")

      if(!uvm_config_db#(virtual my_interface)::get(this, "", "my_interface", my_vif))
         `uvm_fatal("NOVIF", "Cannot find Virtual Interface settings")
   endfunction


   task run_phase(uvm_phase phase);
      int count;

      //Initial Delay
      #50;

      forever
      begin
         count++;

         hb_objection.raise_objection(this);
         `uvm_info("COMP", "Heartbeat Objection Raised", UVM_NONE)

         my_vif.hb_signal <= 1;
         #100;

         `ifdef BUG
            if(count == 8)
            begin
               #100;
               `uvm_info("COMP/BUG", "[8] Exta time delay for HB to expire..", UVM_NONE)
            end
         `endif

         hb_objection.drop_objection(this);
         `uvm_info("COMP", "Heartbeat Objection Dropped", UVM_NONE)

         my_vif.hb_signal <= 0;
         #20;
      end
   endtask

endclass

