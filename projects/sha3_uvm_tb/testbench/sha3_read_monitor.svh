/*
	Description: Monitor class in UVM environment.
	Author: Mayur Kubavat
	Date: 20 Feb 2015
	Purpose:
	-> Observes stimulus on Virtual Interface,
	-> Convert Signal Level activity to transactions,
	-> Implement Monitor Stimulus Analysis Port,
	-> Send transactions to scoreboard via analysis port.
*/

class sha3_read_monitor extends uvm_monitor;
	`uvm_component_utils(sha3_read_monitor)

	virtual sha3_intf sha3_vif;
	
	uvm_analysis_port #(sequence_item) read_monitor_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(virtual sha3_intf)::get(null, "*", "sha3_vif", sha3_vif))
		`uvm_error("", "uvm_config_db::get failed")
		read_monitor_ap = new("read_monitor_ap", this);
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		forever
		begin
		@(sha3_vif.clk)
			get_transaction();
			if(sha3_vif.out_ready)
			begin
				`uvm_info("READ_MONITOR", $sformatf("Received %h", sha3_vif.out), UVM_MEDIUM)
				get_transaction();
			end
		end
	endtask: run_phase

	task get_transaction();
		sequence_item transaction_h;
		transaction_h = new("transaction_h");
		transaction_h.out = sha3_vif.out;
		transaction_h.buffer_full = sha3_vif.buffer_full;
		transaction_h.out_ready = sha3_vif.out_ready;
		read_monitor_ap.write(transaction_h);
   endtask: get_transaction

endclass: sha3_read_monitor
