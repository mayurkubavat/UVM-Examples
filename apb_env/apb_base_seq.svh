
//APB Base Sequence has common methods used by other
//sequences..
class apb_base_seq extends uvm_sequence#(apb_xtn);

    `uvm_object_utils(apb_base_seq)


    //------------------------------------------------
    // Methods
    //------------------------------------------------

    extern function new(string name = "apb_base_seq");

endclass: apb_base_seq

//Constructor
function apb_base_seq::new(string name = "apb_base_seq");
    super.new(name);
endfunction

