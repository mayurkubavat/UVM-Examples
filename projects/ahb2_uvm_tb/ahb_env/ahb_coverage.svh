/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: Subscriber
 Filename: ahb_coverage.svh
**********************************************************/

class ahb_coverage extends uvm_subscriber#(ahb_mxtn);

        `uvm_component_utils(ahb_coverage)

        env_config env_cfg;

        ahb_mxtn ahb_xtn, xtn;

        //Stats
        real cov;

        covergroup ahb_cg;

                option.per_instance = 1;

                RST: coverpoint ahb_xtn.reset;
                WR: coverpoint ahb_xtn.read_write;
                TRANS: coverpoint ahb_xtn.trans_type[0];
                SIZE: coverpoint ahb_xtn.trans_size {bins s[] = {[BYTE:WORD]};}
                //ERR_SIZE: coverpoint ahb_xtn.trans_size {bins e_s[] = {[WORDx2:WORDx32]};}
                BURST: coverpoint ahb_xtn.burst_mode;
                ADDR: coverpoint ahb_xtn.address[0] {option.auto_bin_max = 32;}
                WDATA: coverpoint ahb_xtn.write_data[0] {option.auto_bin_max = 32;}
                RDATA: coverpoint ahb_xtn.read_data {option.auto_bin_max = 32;}
                RESP: coverpoint ahb_xtn.response {bins rsp[] = {OKAY, ERROR};}
                RDY: coverpoint ahb_xtn.ready;
                WRxSIZE: cross WR, SIZE;
                BURSTxSIZE: cross BURST, SIZE;
                WRxBURST: cross WR, BURST;
                WRxBURSTxSIZE: cross WR, BURST, SIZE;

        endgroup


        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "ahb_coverage", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void write(ahb_mxtn t);
        extern function void extract_phase(uvm_phase phase);
        extern function void report_phase(uvm_phase phase);

endclass: ahb_coverage

        //Constructor
        function ahb_coverage::new(string name = "ahb_coverage", uvm_component parent);
                super.new(name, parent);

                ahb_cg = new();
        endfunction

        //Build
        function void ahb_coverage::build_phase(uvm_phase phase);
                if(!uvm_config_db#(env_config)::get(this, "", "env_config", env_cfg))
                begin
                        `uvm_fatal(get_full_name(), "Cannot get ENV-CONFIG from configuration database!")
                end
                xtn = new("xtn");
                super.build_phase(phase);
        endfunction

        function void ahb_coverage::write(ahb_mxtn t);
                ahb_xtn = t;
                ahb_cg.sample();
        endfunction

        //Extract
        function void ahb_coverage::extract_phase(uvm_phase phase);
                cov = ahb_cg.get_coverage();
        endfunction

        //Report
        function void ahb_coverage::report_phase(uvm_phase phase);
                `uvm_info(get_type_name(), $sformatf("Coverage is: %f", cov), UVM_MEDIUM)
        endfunction

