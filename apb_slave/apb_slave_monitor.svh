class apb_slave_monitor extends uvm_monitor;

    `uvm_component_utils(apb_slave_monitor)

    virtual apb_if apb_intf;

    uvm_analysis_port#(apb_xtn) monitor_ap;


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);

        monitor_ap = new("monitor_ap", this);
    endfunction //new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction //build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction //connect_phase

    task run_phase(uvm_phase phase);

    endtask //run_phase

endclass //apb_slave_monitor
