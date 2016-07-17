class apb_bridge_config extends uvm_object;

    `uvm_object_utils(apb_bridge_config)

    virtual apb_if apb_intf;
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    //
    //Methods
    //

    //Constructor
    function new(string name = "apb_bridge_config");
        super.new(name);
    endfunction //new

endclass //apb_bridge_config
