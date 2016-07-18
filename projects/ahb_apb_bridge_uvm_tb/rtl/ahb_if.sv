/*****************************************************************
 * Filename: ahb_if.sv
 * Module Name: ahb_if
 * Author: Mayur
 * Creation Date: 7 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> AHB Interface Signals
 * **************************************************************/

interface ahb_if(input HCLK);

	logic HRESETn;
	logic [1:0] HTRANS;
	logic HWRITE;
	logic HREADYin;
	logic [31:0] HADDR;
	logic [2:0] HBURST;
	logic [31:0] HWDATA;
	logic [1:0] HRESP;
	logic [31:0] HRDATA;
	logic [2:0] HSIZE;
	logic HREADYout;

	//AHB Driver Clocking Block
	clocking ahb_drv_cb @(posedge HCLK);
		default input #1 output #1;
		
		output HRESETn;
		output HTRANS;
		output HWRITE;
		output HREADYin;
		output HADDR;
		output HBURST;
		output HWDATA;
		output HSIZE;
		input HRESP;
		input HRDATA;
		input HREADYout;
	
	endclocking

	//AHB Monitor Block
	clocking ahb_mon_cb @(posedge HCLK);	
		default input #1 output #1;
		
		input HRESETn;
		input HTRANS;
		input HWRITE;
		input HREADYin;
		input HADDR;
		input HBURST;
		input HWDATA;
		input HRESP;
		input HSIZE;
		input HRDATA;
		input HREADYout;

	endclocking

	//Modports
	modport DRV_MP(clocking ahb_drv_cb);
	modport MON_MP(clocking ahb_mon_cb);

endinterface

