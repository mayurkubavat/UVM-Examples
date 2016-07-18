/**********************************************************
 Start Date: 22 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: Reset Driver
 Filename: reset_driver.svh
**********************************************************/

class reset_driver extends uvm_driver#(ahb_mxtn);

        `uvm_component_utils(reset_driver)

        virtual ahb_intf vif;

        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "reset_driver", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task reset();

endclass: reset_driver

        //Constructor
        function reset_driver::new(string name = "reset_driver", uvm_component parent);
                super.new(name, parent);
        endfunction

        //Build
        function void reset_driver::build_phase(uvm_phase phase);
                if(!uvm_config_db#(virtual ahb_intf)::get(this, "", "reset_controller", vif))
                begin
                        `uvm_fatal(get_full_name(), "Cannot get VIF from configuration database!")
                end

                super.build_phase(phase);
        endfunction

        //Run
        task reset_driver::run_phase(uvm_phase phase);
                forever
                begin
                        seq_item_port.get_next_item(req);
                                reset();
                        seq_item_port.item_done(req);
                end
        endtask

        //Reset
        task reset_driver::reset();
                if(req.reset)
                begin
                        vif.HRESETn <= 1'b1;
                        @(vif.mdrv_cb);
                end
                else
                begin
                        vif.HRESETn <= 1'b0;
                        @(vif.mdrv_cb);
                end
        endtask

