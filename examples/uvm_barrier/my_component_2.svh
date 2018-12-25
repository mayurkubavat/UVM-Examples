class my_component_2 extends uvm_component;
   `uvm_component_utils(my_component_2)

   virtual my_interface my_vintf;
   uvm_barrier barrier;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void connect_phase(uvm_phase phase);
      if(!uvm_config_db#(virtual my_interface)::get(this, "", "my_interface", my_vintf))
         `uvm_fatal("NOVIF", "Cannont find Virtual Interface setting")
   endfunction

   task run_phase(uvm_phase phase);
      `uvm_info("COMP2", "Inside run_phase()", UVM_NONE)
      
      barrier.wait_for();
      `uvm_info("COMP2", "Reached barrier synchronization..", UVM_NONE)

      // Reset the barrier
      barrier.reset();

      #40;

      barrier.wait_for();
      `uvm_info("COMP2", "Reached barrier synchronization.. (1)", UVM_NONE)

   endtask


endclass

