class my_monitor extends uvm_monitor;
   `uvm_component_utils(my_monitor)
   
   baseInterface baseInterfaceH;
   virtual my_interface vif;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      if(!uvm_config_db#(virtual my_interface)::get(this, "", "vif", vif))
         `uvm_fatal("NOVIF", "Virtual Interface not Found!")
   endfunction

   function void get();
   endfunction

endclass
