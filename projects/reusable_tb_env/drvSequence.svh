class drvSequence extends uvm_sequence#(myTransaction);
   `uvm_object_utils(drvSequence)

   baseInterface baseInterfaceH;

   function new(string name = "drvSequence");
      super.new(name);
   endfunction

   function void set(baseInterface baseInterfaceH);
      this.baseInterfaceH = baseInterfaceH;
   endfunction


   task body();
      req = myTransaction::type_id::create("req");
      start_item(req);
         req.baseInterfaceH = baseInterfaceH;
      finish_item(req);
   endtask

endclass
