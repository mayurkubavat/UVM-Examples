/**********************************************************
 Start Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Interface
 Filename: ahb_intf.sv
**********************************************************/

interface ahb_intf(input logic HCLK);

        logic HRESETn;
        logic HREADY;
        logic [1:0] HTRANS;
        logic [2:0] HBURST;
        logic [2:0] HSIZE;
        logic HWRITE;
        logic [31:0] HADDR;
        logic [31:0] HWDATA;
        logic [31:0] HRDATA;
        logic [1:0] HRESP;


        clocking mdrv_cb@(posedge HCLK);
                default input #1 output #0;

                output HTRANS;
                output HBURST;
                output HSIZE;
                output HWRITE;
                output HADDR;
                output HWDATA;
                input HREADY;
                input negedge HRESP;
                input HRDATA;

        endclocking
        clocking mmon_cb@(posedge HCLK);
                default input #1 output #0;

                input HRESETn;
                input HREADY;
                input HTRANS;
                input HBURST;
                input HSIZE;
                input HWRITE;
                input HADDR;
                input HWDATA;
                input HRESP;
                input HRDATA;

        endclocking

        clocking sdrv_cb@(posedge HCLK);
                default input #1 output #0;

                input HTRANS;
                input HBURST;
                input HSIZE;
                input HWRITE;
                input HADDR;
                input HWDATA;
                inout HREADY;
                output HRESP;
                output negedge HRDATA;

        endclocking

        clocking smon_cb@(posedge HCLK);
                default input #1 output #0;

                input HREADY;
                input HTRANS;
                input HBURST;
                input HSIZE;
                input HWRITE;
                input HADDR;
                input HWDATA;
                input HRESP;
                input HRDATA;

        endclocking


        modport MDRV_MP(clocking mdrv_cb, input HRESETn);
        modport MMON_MP(clocking mmon_cb, input HRESETn);
        modport SDRV_MP(clocking sdrv_cb, input HRESETn);
        modport SMON_MP(clocking smon_cb, input HRESETn);


//-------------------------------------------------------------
// SVA
//-------------------------------------------------------------


        // Second Cycle of HRESP should have HTRANS == IDLE to
        // cancel data phase of previous transaction
        
        //Error Response followed by Idle Trans
        property idle_on_err_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HRESP == 1) ##1 (HRESP == 1) |-> (HTRANS == 0);
        endproperty
        
        IDLE_on_ERROR: 
           assert property(idle_on_err_p)
              else
           $info("non-IDLE transaction detected on 2nd cycle of error response");


        //Split Response followed by Idle Trans
        property idle_on_split_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HRESP == 3) ##1 (HRESP == 3) |-> (HTRANS == 0);
        endproperty
        
        IDLE_on_SPLIT:
           assert property(idle_on_split_p)
              else
           $info("non-IDLE transaction detected on 2nd cycle of split response");


        //Retry Response followed by Idle Trans
        property idle_on_retry_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HRESP == 2) ##1 (HRESP == 2) |-> (HTRANS == 0);
        endproperty
        
        IDLE_on_RETRY:
           assert property(idle_on_retry_p)
              else
           $info("non-IDLE transaction detected on 2nd cycle of retry response");



        //NONSEQ (BURST = 0) should not follow BUSY
        property no_busy_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HBURST == 0) |=> (HTRANS != 1);
        endproperty

        //Busy followed by Idle
        property busy_idle_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 1) ##1 (HTRANS == 0) |-> ($past(HBURST, 1) == 1);
        endproperty

        //Okay Resp for Idle Trans
        property idle_okay_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 0) |=> (HRESP == 0);
        endproperty

        //Busy on Address and Write Data
        property busy_write_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        ((HTRANS == 1) && (HWRITE)) ##1 (HTRANS != 0) |=> (($past(HWDATA, 1) == $past(HWDATA, 2)) &&
                ($past(HADDR, 1) == $past(HADDR, 2)));
        endproperty

        //Busy on Address and Read Data
        property busy_read_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        ((HTRANS == 1) && (!HWRITE)) ##1 (HTRANS != 0) |=> (($past(HRDATA, 1) == $past(HRDATA, 2)) &&
                ($past(HADDR, 1) == $past(HADDR, 2)));
        endproperty
        // 1KB Boundry Check
        property kb_boundry_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) |-> (HADDR[10:0] != 11'b1_00000_00000);
        endproperty

        //Address Check for INCR/INCRx
        property incr_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && ((HBURST == 1)||(HBURST == 3)||(HBURST == 5)||(HBURST == 7)) &&
                ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |-> (HADDR == ($past(HADDR, 1) + 2**HSIZE));
        endproperty

        //Address Check for WRAP4 Byte
        property wrap4_size0_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 2) && (HSIZE == 0) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[1:0] == ($past(HADDR[1:0], 1) + 1)) && (HADDR[31:2] == $past(HADDR[31:2], 1)));
        endproperty

        //Address Check for WRAP4 Halfword      
        property wrap4_size1_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 2) && (HSIZE == 1) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[2:1] == ($past(HADDR[2:1], 1) + 1)) && (HADDR[31:3] == $past(HADDR[31:3], 1)));
        endproperty

        //Address Check for WRAP4 Word  
        property wrap4_size2_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 2) && (HSIZE == 2) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[3:2] == ($past(HADDR[3:2], 1) + 1)) && (HADDR[31:4] == $past(HADDR[31:4], 1)));
        endproperty

        //Address Check for WRAP8 Byte  
        property wrap8_size0_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 4) && (HSIZE == 0) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[2:0] == ($past(HADDR[2:0], 1) + 1)) && (HADDR[31:3] == $past(HADDR[31:3], 1)));
        endproperty

        //Address Check for WRAP8 Halfword      
        property wrap8_size1_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 4) && (HSIZE == 1) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[3:1] == ($past(HADDR[3:1], 1) + 1)) && (HADDR[31:4] == $past(HADDR[31:4], 1)));
        endproperty

        //Address Check for WRAP8 Word  
        property wrap8_size2_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 4) && (HSIZE == 2) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[4:2] == ($past(HADDR[4:2], 1) + 1)) && (HADDR[31:5] == $past(HADDR[31:5], 1)));
        endproperty

        //Address Check for WRAP16 Byte 
        property wrap16_size0_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 6) && (HSIZE == 0) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[3:0] == ($past(HADDR[3:0], 1) + 1)) && (HADDR[31:4] == $past(HADDR[31:4], 1)));
        endproperty

        //Address Check for WRAP16 Halfword     
        property wrap16_size1_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 6) && (HSIZE == 1) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[4:1] == ($past(HADDR[4:1], 1) + 1)) && (HADDR[31:5] == $past(HADDR[31:5], 1)));
        endproperty

        //Address Check for WRAP16 Word 
        property wrap16_size2_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        (HTRANS == 3) && (HBURST == 6) && (HSIZE == 2) && ($past(HTRANS, 1) != 1) && ($past(HREADY, 1)) |->
                ((HADDR[5:2] == ($past(HADDR[5:2], 1) + 1)) && (HADDR[31:6] == $past(HADDR[31:6], 1)));
        endproperty

        // Address Boundry Aligned for Halfword
        property size1_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        HSIZE == 1 |-> HADDR[0] == 0;
        endproperty

        // Address Boundry Aligned for Word
        property size2_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        HSIZE == 2 |-> HADDR[1:0] == 0;
        endproperty

        // Address Boundry Aligned for Wordx2
        property size3_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        HSIZE == 3 |-> HADDR[2:0] == 0;
        endproperty

        // Address Boundry Aligned for Wordx4
        property size4_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        HSIZE == 4 |-> HADDR[3:0] == 0;
        endproperty

        // Address Boundry Aligned for Wordx8
        property size5_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        HSIZE == 5 |-> HADDR[4:0] == 0;
        endproperty

        // Address Boundry Aligned for Wordx16
        property size6_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        HSIZE == 6 |-> HADDR[5:0] == 0;
        endproperty

        // Address Boundry Aligned for Wordx32
        property size7_addr_p;
                @(posedge HCLK) disable iff(!HRESETn)
                        HSIZE == 7 |-> HADDR[6:0] == 0;
        endproperty


        NO_BUSY: assert property(no_busy_p);
        BUSY_IDLE: assert property(busy_idle_p);
        IDLE_OK: assert property(idle_okay_p);
        BUSY_WRITE: assert property(busy_write_p);
        BUSY_READ: assert property(busy_read_p);
        ONE_KB: assert property(kb_boundry_p);

        INCR_ADDR: assert property(incr_addr_p);

        WRAP4_SIZE0: assert property(wrap4_size0_addr_p);
        WRAP4_SIZE1: assert property(wrap4_size1_addr_p);
        WRAP4_SIZE2: assert property(wrap4_size2_addr_p);
        WRAP8_SIZE0: assert property(wrap8_size0_addr_p);
        WRAP8_SIZE1: assert property(wrap8_size1_addr_p);
        WRAP8_SIZE2: assert property(wrap8_size2_addr_p);
        WRAP16_SIZE0: assert property(wrap16_size0_addr_p);
        WRAP16_SIZE1: assert property(wrap16_size1_addr_p);
        WRAP16_SIZE2: assert property(wrap16_size2_addr_p);

        SIZE1_ADDR_BOUD: assert property(size1_addr_p);
        SIZE2_ADDR_BOUD: assert property(size2_addr_p);
        SIZE3_ADDR_BOUD: assert property(size3_addr_p);
        SIZE4_ADDR_BOUD: assert property(size4_addr_p);
        SIZE5_ADDR_BOUD: assert property(size5_addr_p);
        SIZE6_ADDR_BOUD: assert property(size6_addr_p);
        SIZE7_ADDR_BOUD: assert property(size7_addr_p);

endinterface

