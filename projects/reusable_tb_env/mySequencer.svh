class mySequencer extends uvm_sequencer#(myTransaction);
   `uvm_component_utils(mySequencer)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

endclass
