class apb_slave_config extends uvm_object;

    `uvm_object_utils(apb_slave_config)


    //
    //Methods
    //

    //Constructor
    function new(string name = "apb_slave_config");
        super.new(name);
    endfunction //new

endclass //apb_slave_config
