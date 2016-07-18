/*****************************************************************
 * Filename: ahb_driver.svh
 * Class Name: ahb_driver
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date: ___ Aug 2015
 * --------------------------------------------------------------
 *  -> Get Virtual Interface from ENV Configuration
 *  -> Drive AHB Transaction on to AHB-APB Bridge
 * **************************************************************/

class ahb_driver extends uvm_driver#(ahb_xtn);

	//Factory Registration
	`uvm_component_utils(ahb_driver)

	//Agent Configuration Object
	ahb_agent_config cfg_h;

	//Virtual Interface Handle
	virtual ahb_if.DRV_MP vif;

	//AHB Transaction Handle
	ahb_xtn xtn;

	//----------------------------------------------
	// Methods
	// ---------------------------------------------
	extern function new(string name = "ahb_driver", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task drive();

endclass: ahb_driver


//Constructor
function ahb_driver::new(string name = "ahb_driver", uvm_component parent);
	super.new(name, parent);
endfunction


//Build Phase
function void ahb_driver::build_phase(uvm_phase phase);
	//Get Configuration Object from AHB Agent
	if(!uvm_config_db#(ahb_agent_config)::get(this, "", "ahb_agent_config", cfg_h))
		`uvm_fatal("AHB_DRIVER", "Cannot get vif from AHB Agent")

	super.build_phase(phase);
endfunction


//Connect Phase
function void ahb_driver::connect_phase(uvm_phase phase);
	vif = cfg_h.vif;
endfunction


//End of Elaboration Phase
function void ahb_driver::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("AHB_DRIVER", {get_full_name(), " Created.."}, UVM_MEDIUM);
endfunction


//Run Phase
task ahb_driver::run_phase(uvm_phase phase);

	forever
	begin
		seq_item_port.get_next_item(req);
		drive();
		seq_item_port.item_done();
	end
endtask


//Drive
task ahb_driver::driver();
	
	// Drive Control Signals
	vif.ahb_drv_cb.HWRITE <= req.HWRITE;
	vif.ahb_drv_cb.HBURST <= req.HBURST;
	vif.ahb_drv_cb.HREADYin <= req.HREADYin;
	vif.ahb_drv_cb.HTRANS <= req.HTRANS;
	vif.ahb_drv_cb.HSIZE <= req.HSIZE;
	

	foreach(req.DATA[i])
	begin
		vif.ahb_drv_cb.HADDR <= req.HADDR;
		//wait(vif.ahb_drv_cb.HREADYout);
		@(vif.ahb_drv_cb.HCLK);
		vif.ahb_drv_cb.HDATA <= req.HWDATA[i];

		if((req.HBURST != 3'b000) && (req.HWDATA.size > 1))
		begin
			//Update HTRANS to SEQUENTIAL
			vif.ahb_drv_cb.HTRANS <= 2'b11;
			
			//Update req.HADDR field according to BURST Mode
			req.ADDR = req.ADDR + 2^(req.HSIZE);
		end
	end
	

endtask
