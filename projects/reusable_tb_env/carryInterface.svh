class carryInterface extends baseInterface;
   `uvm_object_utils(carryInterface)

   bit carry;

   function new(string name = "carryInterface");
      super.new(name);
   endfunction

   function bit get(virtual myInterface vif);
      return vif.monCb.carry;
   endfunction

endclass
