class inpInterface extends baseInterface;
   `uvm_object_utils(inpInterface)

   bit [2:0] inp;

   function new(string name = "inpInterface");
      super.new(name);
   endfunction

   function void set(bit [2:0] inp);
      this.inp = inp;
   endfunction

   function bit [3:0] get(virtual myInterface vif);
      return vif.monCb.inp;
   endfunction

endclass
