/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: TOP
 Filename: top.sv
**********************************************************/

module top;

        `include "uvm_macros.svh"
        import uvm_pkg::*;
        import ahb_test_pkg::*;

        logic clock;

        initial
        begin
                clock = 0;
                forever #10 clock = ~clock;
        end

        ahb_intf intf(clock);


        initial
        begin
                uvm_config_db#(virtual ahb_intf)::set(null, "*", "ahb_intf", intf);

                run_test();

        end

endmodule

