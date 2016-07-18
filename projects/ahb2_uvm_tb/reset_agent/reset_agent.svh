/**********************************************************
 Start Date: 22 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: Reset Controller Agent
 Filename: reset_agent.svh
**********************************************************/

class reset_agent extends uvm_agent;

        `uvm_component_utils(reset_agent)

        reset_driver driver_h;
        reset_seqr reset_seqr_h;

        //--------------------------------------------
        // Methods
        //--------------------------------------------

        extern function new(string name = "reset_agent", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

endclass: reset_agent

        //Constructor
        function reset_agent::new(string name = "reset_agent", uvm_component parent);
                super.new(name, parent);
        endfunction

        //Build
        function void reset_agent::build_phase(uvm_phase phase);
                super.build_phase(phase);

                driver_h = reset_driver::type_id::create("driver_h", this);
                reset_seqr_h = reset_seqr::type_id::create("reset_seqr_h", this);
        endfunction

        //Connect
        function void reset_agent::connect_phase(uvm_phase phase);
                driver_h.seq_item_port.connect(reset_seqr_h.seq_item_export);
        endfunction


