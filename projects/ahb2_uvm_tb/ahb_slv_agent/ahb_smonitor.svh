/**********************************************************
 Start Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Slave Monitor
 Filename: ahb_smonitor.svh
**********************************************************/

class ahb_smonitor extends uvm_monitor;

        `uvm_component_utils(ahb_smonitor)

        virtual ahb_intf vif;
        ahb_sagent_config sagt_cfg;
        ahb_sxtn xtn;

        uvm_analysis_port#(ahb_sxtn) monitor_ap;


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_smonitor", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task monitor();

endclass: ahb_smonitor

        //Constructor
        function ahb_smonitor::new(string name = "ahb_smonitor", uvm_component parent);
                super.new(name, parent);

                monitor_ap = new("monitor_ap", this);

        endfunction

        //Build
        function void ahb_smonitor::build_phase(uvm_phase phase);
                if(!uvm_config_db#(ahb_sagent_config)::get(this, "", "ahb_sagent_config", sagt_cfg))
                begin
                        `uvm_fatal(get_full_name(), "Cannot get VIF from configuration database!")
                end

                super.build_phase(phase);
        endfunction

        //Connect
        function void ahb_smonitor::connect_phase(uvm_phase phase);
                vif = sagt_cfg.vif;
        endfunction

        //Run
        task ahb_smonitor::run_phase(uvm_phase phase);
                forever
                begin
                        fork
                                begin: mon
                                        monitor();
                                        disable wait_for_reset;
                                end
                                begin: wait_for_reset
                                        wait(!vif.HRESETn);
                                        xtn = ahb_sxtn::type_id::create("xtn");
                                        xtn.reset =  0;
                                        $cast(xtn.trans_type, vif.HTRANS);
                                        disable mon;
                                        monitor_ap.write(xtn);
                                        @(vif.smon_cb);
                                end
                        join
                end
        endtask

        //Monitor Bursts
        task ahb_smonitor::monitor();
        begin: mon1
                xtn = ahb_sxtn::type_id::create("xtn");

                do
                begin: collect
                        $cast(xtn.trans_type, vif.mmon_cb.HTRANS);
                        $cast(xtn.burst_mode, vif.mmon_cb.HBURST);
                        $cast(xtn.trans_size, vif.mmon_cb.HSIZE);
                        $cast(xtn.read_write, vif.mmon_cb.HWRITE);
                        $cast(xtn.response, vif.mmon_cb.HRESP);
                        xtn.address.push_back(vif.mmon_cb.HADDR);

                        if((xtn.trans_type == IDLE) && (vif.HRESETn == 1))
                        begin
                                @(vif.mmon_cb);
                                `uvm_info(get_type_name(), "IDLE Transaction Detected..", UVM_MEDIUM)
                                monitor_ap.write(xtn);
                                disable mon1;
                        end
                        else
                        begin
                                @(vif.mmon_cb);
                                if(vif.HRESP == 1)
                                begin
                                        `uvm_info(get_type_name(), $sformatf("ERROR Detected on Address %h", xtn.address[$]), UVM_MEDIUM)
                                        disable collect;
                                end

                                while(!vif.HREADY || (vif.HTRANS == 1))
                                begin
                                        @(vif.mmon_cb);
                                        if(vif.HRESP == 1)
                                        begin
                                                `uvm_info(get_type_name(), $sformatf("ERROR Detected on Address %h", xtn.address[$]), UVM_MEDIUM)
                                                disable collect;
                                        end
                                end

                                if(xtn.read_write == READ)
                                        xtn.read_data.push_back(vif.mmon_cb.HRDATA);
                                else
                                        xtn.write_data.push_back(vif.mmon_cb.HWDATA);
                        end
                end: collect
                while(vif.HTRANS == 3);

                `uvm_info(get_type_name(), "Received Packet From AHB Slave Monitor..", UVM_MEDIUM)
                xtn.print();
                monitor_ap.write(xtn);
        end
        endtask

