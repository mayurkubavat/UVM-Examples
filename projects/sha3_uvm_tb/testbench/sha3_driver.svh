/*
	Description: Driver class in UVM environment.
	Author: Mayur Kubavat
	Date: 17 Feb 2015
	Purpose:
	-> Extends UVM Driver base class,
	-> Accepts Sequence Item as parameter argument,
	-> Perform Pin Wiggle to Keccak SHA-3 DUT through 
	Virtual Interface.
*/

class sha3_driver extends uvm_driver#(sequence_item);
	`uvm_component_utils(sha3_driver)

	virtual sha3_intf sha3_vif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(virtual sha3_intf)::get(this, "", "sha3_vif", sha3_vif)) begin
			`uvm_error("", "uvm_config::get failed")
		end
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		sequence_item cmd;
		forever begin
			seq_item_port.get_next_item(cmd);
			sha3_vif.reset = cmd.reset;
			sha3_vif.in = cmd.in;
			sha3_vif.in_ready = cmd.in_ready;
			sha3_vif.is_last = cmd.is_last;
			sha3_vif.byte_num = cmd.byte_num;
			seq_item_port.item_done();
		end
	endtask: run_phase

endclass: sha3_driver
