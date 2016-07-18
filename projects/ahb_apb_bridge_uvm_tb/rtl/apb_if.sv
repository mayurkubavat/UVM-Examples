/*****************************************************************
 * Filename: apb_if.sv
 * Module Name: apb_if
 * Author: Mayur
 * Creation Date: 7 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> APB Interface Signals
 * **************************************************************/

interface apb_if();

	logic PENABLE;
	logic PSELx;
	logic PWRITE;
	logic [31:0] PADDR;
	logic [31:0] PWDATA;
	logic [31:0] PRDATA;

	//APB Driver Modport
	modport DRV_MP(	input PENABLE,
			input PSELx,
			input PWRITE,
			input PADDR,
			input PWDATA,
			output PRDATA
		       );

	//APB Monitor Modport
	modport MON_MP(	input PENABLE,
			input PSELx,
			input PWRITE,
			input PADDR,
			input PWDATA,
			input PRDATA
		      );

endinterface

