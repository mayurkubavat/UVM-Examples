/*****************************************************************
 * Filename: ahb_xtn.svh
 * Class Name: ahb_xtn
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 * **************************************************************/

class ahb_xtn extends uvm_sequence_item;


	bit HRESETn;
	bit HREADYin = 1'b1;

	//AHB Control Signals
	rand bit [1:0] HTRANS;
	rand bit [2:0] HSIZE;
	rand bit [2:0] HBURST;
	rand bit HWRITE;

	rand bit [31:0] HADDR;
	rand bit [31:0] HWDATA[];

	//AHB Outputs	
	bit HRESP;
	bit HREADYout;
	
	//--------------------------------------------------------------
	// Constraint Definitions
	// -------------------------------------------------------------
	
	//Transaction Type - BUSY Not Supported 
	constraint trans_type {HTRANS != 2'b01;}

	//SIZE {8 Bits, 16 Bits and 32 Bits}
	constraint size_limit{	HSIZE inside {0, 1, 2};}

	// Address Alignment with Word Boundary
	constraint addr {
				if(HSIZE == 3'b001) HADDR[0] == 1'b0;
		        	if(HSIZE == 3'b010) HADDR[1:0] == 2'b00;
			}
	
	//Data Lenth Dependent on WRITE Transaction
	constraint data_length{	
				if(HBURST == 3'b000) HDATA.size == 1;
				if(HBURST == 3'b001) {(HDATA.size >= 1) && (HDATA.size <= (1024/(2^HSIZE)))};
				if(HBURST == 3'b010) HDATA.size == 4;
				if(HBURST == 3'b011) HDATA.size == 4;
				if(HBURST == 3'b100) HDATA.size == 8;
				if(HBURST == 3'b101) HDATA.size == 8;
				if(HBURST == 3'b110) HDATA.size == 16;
				if(HBURST == 3'b111) HDATA.size == 16;
			      }


	//-------------------------------------------------------
	// Register with Factory
	// ------------------------------------------------------	
	`uvm_object_utils_begin(ahb_xtn)
		`uvm_field_int(HRESETn, UVM_ALL_ON)
		`uvm_field_int(HREADYin, UVM_ALL_ON)
		`uvm_field_int(HTRANS, UVM_ALL_ON)
		`uvm_field_int(HBURST, UVM_ALL_ON)
		`uvm_field_int(HSIZE, UVM_ALL_ON)
		`uvm_field_int(HWRITE, UVM_ALL_ON)
		`uvm_field_int(HADDR, UVM_ALL_ON)
		`uvm_field_int(HWDATA, UVM_ALL_ON)
		`uvm_field_int(HRESP, UVM_ALL_ON)
		`uvm_field_int(HREADYout, UVM_ALL_ON)
	`uvm_object_utils_end


	//-------------------------------------------------------
	// Methods
	// ------------------------------------------------------	
	function new(string name = "ahb_xtn");
		super.new(name);
	endfunction

endclass: ahb_xtn
