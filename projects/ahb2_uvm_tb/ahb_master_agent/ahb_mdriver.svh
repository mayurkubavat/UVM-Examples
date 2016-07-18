/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master Driver
 Filename: ahb_mdriver.svh
**********************************************************/

class ahb_mdriver extends uvm_driver#(ahb_mxtn);

        `uvm_component_utils(ahb_mdriver)

        virtual ahb_intf vif;
        ahb_magent_config magt_cfg;

        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_mdriver", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task drive();

endclass: ahb_mdriver

        //Constructor
        function ahb_mdriver::new(string name = "ahb_mdriver", uvm_component parent);
                super.new(name, parent);
        endfunction

        //Build
        function void ahb_mdriver::build_phase(uvm_phase phase);
                if(!uvm_config_db#(ahb_magent_config)::get(this, "", "ahb_magent_config", magt_cfg))
                begin
                        `uvm_fatal(get_full_name(), "Cannot get VIF from configuration database!")
                end

                super.build_phase(phase);
        endfunction

        //Connect
        function void ahb_mdriver::connect_phase(uvm_phase phase);
                vif = magt_cfg.vif;
        endfunction

        //Run
        task ahb_mdriver::run_phase(uvm_phase phase);
                forever
                begin
                        seq_item_port.get_next_item(req);
                        void'(req.add_busy());
                        fork
                                begin: driver
                                        wait(vif.HRESETn);
                                        drive();
                                        disable resp;
                                        disable rst;
                                end
                                begin:resp
                                        wait(vif.HRESETn);
                                        forever
                                        begin
                                                if((vif.HRESP == 1) && (vif.HTRANS == 0))
                                                        @(vif.mdrv_cb);
                                                else
                                                begin
                                                        wait(vif.mdrv_cb.HRESP == 1);
                                                        disable driver;
                                                        vif.mdrv_cb.HTRANS <= 0;
                                                        @(vif.mdrv_cb);
                                                        disable rst;
                                                        break;
                                                end
                                        end
                                end
                                begin:rst
                                        forever
                                        begin
                                                wait(!vif.HRESETn);
                                                `uvm_info(get_type_name(), "RESET Detected..", UVM_MEDIUM)
                                                disable driver;
                                                disable resp;
                                                vif.HTRANS <= 0;
                                                vif.HBURST <= 0;
                                                vif.HSIZE <= 0;
                                                vif.HWRITE <= 0;
                                                vif.HADDR <= 0;
                                                vif.HWDATA <= 0;

                                                @(vif.mdrv_cb);
                                                if(vif.HRESETn)
                                                        disable rst;
                                        end
                                end

                        join
                        seq_item_port.item_done(req);
                end
        endtask

        //Drive
        task ahb_mdriver::drive();
        begin: drv

                int j;          //Variable to Increment HTRANS Queue
                bit busy_last;

                        `uvm_info(get_type_name(), "Transaction From AHB Master Driver..", UVM_MEDIUM)
                        req.print();

                        //Drive Controls
                        vif.mdrv_cb.HBURST <= req.burst_mode;
                        vif.mdrv_cb.HSIZE <= req.trans_size;
                        vif.mdrv_cb.HWRITE <= req.read_write;


                        //Drive Address, Transaction Type and Data
                        foreach(req.address[i])
                        begin
                                vif.mdrv_cb.HADDR <= req.address[i];
                                if(busy_last)
                                begin
                                        @(vif.mdrv_cb);
                                        busy_last = 0;
                                end
                                vif.mdrv_cb.HTRANS <= req.trans_type[j];
                                if(req.trans_type[j] == 2'b01)
                                begin
                                        do
                                        begin
                                                j++;
                                                @(vif.mdrv_cb);
                                                vif.mdrv_cb.HTRANS <= req.trans_type[j];
                                        end
                                        while(req.trans_type[j] == 2'b01);
                                end
                                @(vif.mdrv_cb);
                                j++;

                                while(!vif.mdrv_cb.HREADY) @(vif.mdrv_cb);
                                if(req.read_write)
                                begin
                                        vif.mdrv_cb.HWDATA <= req.write_data[i];
                                end
                        end
                        if((req.burst_mode == INCR)&&(req.trans_type[j] == 1))
                        begin
                                vif.mdrv_cb.HTRANS <= 1'b1;     //Drive Busy at End
                                busy_last = 1;
                        end
        end
        endtask

