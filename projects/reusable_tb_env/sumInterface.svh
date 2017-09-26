class sumInterface extends baseInterface;
   `uvm_object_utils(sumInterface)

   bit sum;

   function new(string name = "sumInterface");
      super.new(name);
   endfunction

   function bit get(virtual myInterface vif);
      return vif.monCb.sum;
   endfunction

endclass
