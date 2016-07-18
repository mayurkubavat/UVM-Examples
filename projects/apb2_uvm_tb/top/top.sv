module top;

    `include "uvm_macros.svh"

    import uvm_pkg::*;

    import apb_test_pkg::*;

    //APB Clock
    bit clock;
    parameter CYCLE = 10;


    //APB Interface
    apb_if apb_intf(clock);


    always
    begin
        clock = ~clock;
        #CYCLE;
    end

    initial
    begin

        uvm_config_db#(virtual apb_if)::set(null, "*", "apb_if", apb_intf);

        run_test();

    end //initial

endmodule //test

