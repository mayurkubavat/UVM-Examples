class apb_bridge_config extends uvm_object;

    `uvm_object_utils(apb_bridge_config)


    //
    //Methods
    //

    //Constructor
    function new(string name = "apb_bridge_config");
        super.new(name);
    endfunction //new

endclass //apb_bridge_config
