class my_test extends uvm_test;
   `uvm_component_utils(my_test)

   my_component component;

   uvm_heartbeat           heartbeat;
   uvm_event#(uvm_object)  heartbeat_e;
   uvm_callbacks_objection hb_objection;

   virtual my_interface my_vif;


   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      component = my_component::type_id::create("component", this);

      hb_objection = new("hb_objection");
      heartbeat    = new("heartbeat", this, hb_objection);

      uvm_config_db#(uvm_objection)::set(this, "*", "hb_objection", hb_objection);
   endfunction


   function void connect_phase(uvm_phase phase);
      if(!uvm_config_db#(virtual my_interface)::get(this, "", "my_interface", my_vif))
         `uvm_fatal("NOVIF", "Cannot find Virtual Interface settings")
   endfunction


   task run_phase(uvm_phase phase);
      phase.raise_objection(this);

      heartbeat_e = new("heartbeat_e");
      
      // Add one or more components to monitor hearbeat
      heartbeat.add(component);
      
      // Returns current value of heartbeat mode (type: uvm_heartbeat_modes)
      void'(heartbeat.set_mode(UVM_ANY_ACTIVE));

      // Start HB once all components are added to the list
      heartbeat.start(heartbeat_e);

      repeat(10)
      begin
         // There should be one/more raise/drop objection(s) 
         // for each HB event trigger

         #120 heartbeat_e.trigger(this);
         `uvm_info("TEST/HB", "Trigger HB Event", UVM_NONE)

         // To debug HB events in waveform
         fork
            begin
               my_vif.hb_event <= 1;
               #1;
               my_vif.hb_event <= 0;
            end
         join_none
      end

      heartbeat.stop();
      heartbeat.remove(component);
      
      phase.drop_objection(this);
   endtask

endclass

