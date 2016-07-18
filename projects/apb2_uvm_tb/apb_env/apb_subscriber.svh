class apb_subscriber extends uvm_subscriber#(apb_xtn);

    `uvm_component_utils(apb_subscriber)


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    function void write(apb_xtn t);
    endfunction //write

endclass //apb_subscriber
