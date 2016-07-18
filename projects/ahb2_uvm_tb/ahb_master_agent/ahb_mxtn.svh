/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 18 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master Transaction
 Filename: ahb_mxtn.svh
**********************************************************/

class ahb_mxtn extends uvm_sequence_item;


        rand bit reset;

        //Transfer Type
        rand transfer_t trans_type[];

        //Address and Controls
        rand bit [31:0] address [];
        rand size_t trans_size;
        rand burst_t burst_mode;
        rand rw_t read_write;
        //rand bit [3:0] HPROT;

        rand bit [31:0] write_data [];


        bit ready;
        resp_t response;
        bit [31:0] read_data;

        rand bit busy[];

        rand int no_of_busy;
        constraint rst {reset == 1;}

        constraint busy_count{
                                no_of_busy == write_data.size;
                        }

        constraint busy_pos{
                                busy.size == trans_type.size;
                        }

        constraint addr {
                        //Address Based on BURST Mode and HSIZE
                        if(burst_mode == 0)
                                address.size == 1;
                        if(burst_mode == 1)
                                address.size < (1024/(2^trans_size));
                        if(burst_mode == 2 || burst_mode == 3)
                                address.size == 4;
                        if(burst_mode == 4 || burst_mode == 5)
                                address.size == 8;
                        if(burst_mode == 6 || burst_mode == 7)
                                address.size == 16;
                        }

        constraint min_size_limit {
                                address.size > 0;
                        }

        constraint kb_boundry {
                if(burst_mode == 1)
                        address[0][10:0] <= (1024 - ((address.size)*(2**trans_size)));
                if((burst_mode == 2) || (burst_mode == 3))
                        address[0][10:0] <= (1024 - 4*(2**trans_size));
                if((burst_mode == 4) || (burst_mode == 5))
                        address[0][10:0] <= (1024 - 8*(2**trans_size));

                if((burst_mode == 6) || (burst_mode == 7))
                        address[0][10:0] <= (1024 - 16*(2**trans_size));
        }

        constraint word_boundary{
                        if(trans_size == HALFWORD){
                                foreach(address[i])
                                        address[i][0] == 1'b0;
                        }
                        if(trans_size == WORD){
                                foreach(address[i])
                                        address[i][1:0] == 2'b0;
                        }
                        if(trans_size == WORDx2){
                                foreach(address[i])
                                        address[i][2:0] == 3'b0;
                        }
                        if(trans_size == WORDx4){
                                foreach(address[i])
                                        address[i][3:0] == 4'b0;
                        }
                        if(trans_size == WORDx8){
                                foreach(address[i])
                                        address[i][4:0] == 5'b0;
                        }
                        if(trans_size == WORDx16){
                                foreach(address[i])
                                        address[i][5:0] == 6'b0;
                        }
                        if(trans_size == WORDx32){
                                foreach(address[i])
                                        address[i][6:0] == 7'b0;
                        }
                }

        constraint addr_val {
                        if(burst_mode != 0){
                                if(burst_mode == INCR || burst_mode == INCR4 || burst_mode == INCR8 || burst_mode == INCR16){
                                        foreach(address[i]){
                                                if(i != 0){
                                                address[i] == address[i-1] + 2**trans_size;
                                                }
                                        }
                                }
                        }
                }


        constraint addr_wrap4_8{
                                if((burst_mode == WRAP4) && (trans_size == BYTE)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][1:0] == address[i-1][1:0] + 1;
                                                        address[i][31:2] == address[i-1][31:2];
                                                }
                                        }
                                }
                        }

        constraint addr_wrap4_Halfword{
                                if((burst_mode == WRAP4) && (trans_size == HALFWORD)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][2:1] == address[i-1][2:1] + 1;
                                                        address[i][31:3] == address[i-1][31:3];
                                                }
                                        }
                                }
                        }

        constraint addr_wrap4_Word{
                                if((burst_mode == WRAP4) && (trans_size == WORD)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][3:2] == address[i-1][3:2] + 1;
                                                        address[i][31:4] == address[i-1][31:4];
                                                }
                                        }
                                }
                        }

        constraint addr_wrap8_Byte{
                                if((burst_mode == WRAP8) && (trans_size == BYTE)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][2:0] == address[i-1][2:0] + 1;
                                                        address[i][31:3] == address[i-1][31:3];
                                                }
                                        }
                                }
                        }

        constraint addr_wrap8_Halfword{
                                if((burst_mode == WRAP8) && (trans_size == HALFWORD)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][3:1] == address[i-1][3:1] + 1;
                                                        address[i][31:4] == address[i-1][31:4];
                                                }
                                        }
                                }
                        }

        constraint addr_wrap8_Word{
                                if((burst_mode == WRAP8) && (trans_size == WORD)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][4:2] == address[i-1][4:2] + 1;
                                                        address[i][31:5] == address[i-1][31:5];
                                                }
                                        }
                                }
                        }

        constraint addr_wrap16_Byte{
                                if((burst_mode == WRAP16) && (trans_size == BYTE)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][3:0] == address[i-1][3:0] + 1;
                                                        address[i][31:4] == address[i-1][31:4];
                                                }
                                        }
                                }
                        }

        constraint addr_wrap16_Halfword{
                                if((burst_mode == WRAP16) && (trans_size == HALFWORD)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][4:1] == address[i-1][4:1] + 1;
                                                        address[i][31:5] == address[i-1][31:5];
                                                }
                                        }
                                }
                        }

        constraint adddr_wrap16_Word{
                                if((burst_mode == WRAP16) && (trans_size == WORD)){
                                        foreach(address[i]){
                                                if(i != 0){
                                                        address[i][5:2] == address[i-1][5:2] + 1;
                                                        address[i][31:6] == address[i-1][31:6];
                                                }
                                        }
                                }
                        }


        constraint wdata {
                                write_data.size == address.size;
                        }

        constraint h_size {
                                trans_size < WORDx2;
                        }

        constraint nonseq_idle {
                                if(burst_mode == SINGLE){
                                        trans_type.size == 1;
                                        trans_type[0] inside {IDLE, NONSEQ};
                                }
                        }

        constraint trans {
                        if((address.size == 1) && (burst_mode == INCR)){
                                trans_type.size == 1 + no_of_busy;
                                trans_type[0] == NONSEQ;
                        }
                        else if(burst_mode != SINGLE){
                                trans_type.size == address.size + no_of_busy;
                                foreach(trans_type[i]){
                                        if(i == 0)
                                                trans_type[i] == NONSEQ;
                                        else
                                                trans_type[i] == SEQ;
                                }
                        }
                }


        `uvm_object_utils_begin(ahb_mxtn)
                `uvm_field_int(reset, UVM_ALL_ON)
                `uvm_field_array_enum(transfer_t, trans_type, UVM_ALL_ON)
                `uvm_field_array_int(address, UVM_ALL_ON)
                `uvm_field_enum(size_t, trans_size, UVM_ALL_ON)
                `uvm_field_enum(burst_t, burst_mode, UVM_ALL_ON)
                //`uvm_field_int(HPROT, UVM_ALL_ON)
                `uvm_field_enum(rw_t, read_write, UVM_ALL_ON)
                `uvm_field_array_int(write_data, UVM_ALL_ON)
                //`uvm_field_int(HREADY, UVM_ALL_ON)
                `uvm_field_enum(resp_t, response, UVM_ALL_ON)
                `uvm_field_int(read_data, UVM_ALL_ON)
        `uvm_object_utils_end

        //-----------------------------------------------
        // Methods
        //-----------------------------------------------

        extern function new(string name = "ahb_mxtn");
        extern function add_busy();

endclass: ahb_mxtn

        //Constructor
        function ahb_mxtn::new(string name = "ahb_mxtn");
                super.new(name);
        endfunction
        //Add Busy
        function ahb_mxtn::add_busy();
                if(address.size != 1)
                begin
                        int count;
                        foreach(busy[i])
                        begin
                                if(busy[i] == 1)
                                begin
                                        if(i != 0)
                                        begin
                                                trans_type[i] = BUSY;
                                                count++;
                                        end
                                end
                                if(count == no_of_busy)
                                        break;
                                if((i == (address.size + count)) && (burst_mode != INCR))
                                        break;
                                if((i == (address.size + 1 + count)) && (burst_mode == INCR))
                                        break;
                        end
                end
                else if(no_of_busy > 0)
                begin
                        foreach(trans_type[i])
                        begin
                                if(i != 0)
                                trans_type[i] = BUSY;
                        end
                end
        endfunction

