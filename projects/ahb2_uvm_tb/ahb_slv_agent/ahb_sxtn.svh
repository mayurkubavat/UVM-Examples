/**********************************************************
 Start Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Slave Transaction
 Filename: ahb_sxtn.svh
**********************************************************/

class ahb_sxtn extends uvm_sequence_item;

        bit reset;
        bit [31:0] address[$];
        bit [31:0] write_data[$];
        transfer_t trans_type;
        burst_t burst_mode;
        size_t trans_size;
        rw_t read_write;

        bit [31:0] read_data[$];
        rand resp_t response;
        rand bit ready[];

        constraint ready_wait { ready.size inside {[1:50]}; }


        `uvm_object_utils_begin(ahb_sxtn)
                `uvm_field_int(reset, UVM_ALL_ON)
                `uvm_field_array_int(ready, UVM_ALL_ON)
                `uvm_field_queue_int(address, UVM_ALL_ON)
                `uvm_field_queue_int(write_data, UVM_ALL_ON)
                `uvm_field_enum(transfer_t, trans_type, UVM_ALL_ON)
                `uvm_field_enum(burst_t, burst_mode, UVM_ALL_ON)
                `uvm_field_enum(rw_t, read_write, UVM_ALL_ON)
                `uvm_field_enum(size_t, trans_size, UVM_ALL_ON)
                `uvm_field_queue_int(read_data, UVM_ALL_ON)
                `uvm_field_enum(resp_t, response, UVM_ALL_ON)
        `uvm_object_utils_end

        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "ahb_sxtn");

endclass: ahb_sxtn

        //Constructor
        function ahb_sxtn::new(string name = "ahb_sxtn");
                super.new(name);
        endfunction

