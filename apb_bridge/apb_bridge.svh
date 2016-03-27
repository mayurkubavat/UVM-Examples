class apb_bridge extends uvm_agent;

    `uvm_component_utils(apb_bridge)


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    //Build
    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
    endfunction //buil_phase

endclass //apb_bridge
