class my_base_test extends uvm_test;
   `uvm_component_utils(my_base_test)

   myDriver drv;
   mySequencer seqr;

   inpInterface inpInterfaceH;
   sumInterface sumInterfaceH;
   carryInterface carryInterfaceH;

   drvSequence drvSeq;

   virtual myInterface vif;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
   drv = myDriver::type_id::create("drv", this);
   seqr = mySequencer::type_id::create("seqr", this);

   drv.seq_item_port.connect(seqr.seq_item_export);
   
   if(!uvm_config_db#(virtual myInterface)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual Interface not Found!")
   endfunction

   function void end_of_elaboration_phase(uvm_phase phase);
      uvm_root::print();
   endfunction

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
         inpInterfaceH = inpInterface::type_id::create("inpInterfaceH");
         inpInterfaceH.set(7);

         drvSeq = drvSequence::type_id::create("drvSeq");
         drvSeq.set(inpInterfaceH);
         drvSeq.start(seqr);

         #50 $display($time, ": Sum is %d", sumInterfaceH.get(vif));
         $display($time, ": Carry is %d", carryInterfaceH.get(vif));
   
         inpInterfaceH.set(inpInterfaceH.get(vif) & 3'b110);
         drvSeq.set(inpInterfaceH);
         drvSeq.start(seqr);
         #50 $display($time, ": Sum is %d", sumInterfaceH.get(vif));
         $display($time, ": Carry is %d", carryInterfaceH.get(vif));
   

         #100;
      phase.drop_objection(this);
   endtask

endclass
