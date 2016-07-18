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

class sha3_write_monitor extends uvm_monitor;
	`uvm_component_utils(sha3_write_monitor)

	virtual sha3_intf sha3_vif;
	
	uvm_analysis_port #(sequence_item) write_monitor_ap;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(virtual sha3_intf)::get(null, "*", "sha3_vif", sha3_vif))
		`uvm_error("", "uvm_config_db::get failed")
		write_monitor_ap = new("write_monitor_ap", this);
	endfunction: build_phase

	task run_phase(uvm_phase phase);
	forever
	begin
		@(posedge sha3_vif.clk)
		$display("---------------------------------------------------");
		`uvm_info("WRITE_MONITOR", $sformatf("Received Data\n\t in = %h\n\tin_ready = %b\n\tis_last = %b\n\tbyte_num = %b", sha3_vif.in, sha3_vif.in_ready, sha3_vif.is_last, sha3_vif.byte_num), UVM_MEDIUM)
		$display("---------------------------------------------------");
		get_transaction();
	end
	endtask: run_phase

	task get_transaction();
		sequence_item transaction_h;
		transaction_h = new("transaction_h");
		transaction_h.in = sha3_vif.in;
		transaction_h.in_ready = sha3_vif.in_ready;
		transaction_h.is_last = sha3_vif.is_last;
		transaction_h.byte_num = sha3_vif.byte_num;
		write_monitor_ap.write(transaction_h);
   endtask: get_transaction

endclass: sha3_write_monitor
