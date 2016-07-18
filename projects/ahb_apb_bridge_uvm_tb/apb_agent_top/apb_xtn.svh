/*****************************************************************
 * Filename: apb_xtn.svh
 * Class Name: apb_xtn
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 * **************************************************************/

class apb_xtn extends uvm_sequence_item;

	bit PENABLE;
	bit PSELx;
	bit PWRITE;
	bit [31:0] PADDR;
	bit [31:0] PWDATA;
	bit [31:0] PRDATA;

	//Register with Factory
	`uvm_object_utils_begin(apb_xtn)
		`uvm_field_int(PENABLE, UVM_ALL_ON)
		`uvm_field_int(PSELx, UVM_ALL_ON)
		`uvm_field_int(PWRITE, UVM_ALL_ON)
		`uvm_field_int(PADDR, UVM_ALL_ON)
		`uvm_field_int(PWDATA, UVM_ALL_ON)
		`uvm_field_int(PRDATA, UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "apb_xtn");
		super.new(name);
	endfunction

endclass: apb_xtn
