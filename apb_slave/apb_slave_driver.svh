class apb_slave_driver extends uvm_driver#(apb_xtn);

    `uvm_component_utils(apb_slave_driver)

    virtual apb_if apb_intf;

    apb_slave_config slave_cfg_h;


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(apb_slave_config)::get(this, "", "apb_slave_config", slave_cfg_h))
        begin
                `uvm_fatal("APB/SLAVE/DRV", "Cannot get VIF from configuration database!")
        end

        super.build_phase(phase);
    endfunction //build_phase

    function void connect_phase(uvm_phase phase);
        apb_intf = slave_cfg_h.apb_intf;

        super.connect_phase(phase);
    endfunction //connect_phase

    extern task drive();

    task run_phase(uvm_phase phase);

        fork
            //Detect RESET signals, Disable Driver on detection
            forever
            begin
                wait(!apb_intf.PRESETn);
                `uvm_info("APB/SLAVE/DRV", "RESET assertion detected..", UVM_MEDIUM)
                disable driver;
                apb_intf.PREADY <= 0;
                apb_intf.PSLVERR <= 0;
                apb_intf.PRDATA <= 0;

                wait(apb_intf.PRESETn);
                `uvm_info("APB/SLAVE/DRV", "RESET deassertion detected..", UVM_MEDIUM)
            end

            forever
            begin
                begin: driver
                    wait(apb_intf.PRESETn);
                    drive();
                end //driver
            end
        join

    endtask //run_phase

endclass //apb_slave_driver


task apb_slave_driver::drive();

    do
        repeat({$random}%10)
            @(apb_intf.sdrv_cb);
    while(!apb_intf.sdrv_cb.PENABLE);

    apb_intf.sdrv_cb.PREADY <= 1;

    if(!apb_intf.sdrv_cb.PWRITE)
    begin
        `uvm_info("APB/SLAVE/DRV", "Read request received..", UVM_MEDIUM)
        //Read Operation
        apb_intf.sdrv_cb.PRDATA <= $random;
    end

    @(apb_intf.sdrv_cb);
    apb_intf.sdrv_cb.PREADY <= 0;

endtask
