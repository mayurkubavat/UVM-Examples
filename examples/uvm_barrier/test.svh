class test extends uvm_test;
   `uvm_component_utils(test)

   virtual my_interface my_vintf;
   uvm_barrier c_barrier;

   // Add synchronization points in these 
   // components using uvm_barrier
   my_component_1 comp_1;
   my_component_2 comp_2;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction


   function void build_phase(uvm_phase phase);
      comp_1 = my_component_1::type_id::create("comp_1", this);
      comp_2 = my_component_2::type_id::create("comp_2", this);

      // Create barrier to Sync 2 process
      c_barrier = new("c_barrier", 2);
   endfunction

   function void connect_phase(uvm_phase phase);
      if(!uvm_config_db#(virtual my_interface)::get(this, "", "my_interface", my_vintf))
         `uvm_fatal("NOVIF", "Cannont find Virtual Interface setting")
   endfunction


   function void start_of_simulation_phase(uvm_phase phase);
      // Assign same barrier to different components 
      comp_1.barrier = c_barrier;
      comp_2.barrier = c_barrier;
   endfunction

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
         #100;
      phase.drop_objection(this);
   endtask

endclass

