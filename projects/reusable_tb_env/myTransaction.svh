class myTransaction extends uvm_sequence_item;
   `uvm_object_utils(myTransaction)

   function new(string name = "myTransaction");
      super.new(name);
   endfunction

   baseInterface baseInterfaceH;

endclass
