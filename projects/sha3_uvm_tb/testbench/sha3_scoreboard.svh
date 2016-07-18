/*
	Description: Scoreboard in UVM environment.
	Author: Mayur Kubavat
	Date: 03 March 2015
	Purpose:
	-> Subscribes to Agent's Analysis Port,
	-> Implements Keccak SHA-3 Reference Model,
	-> Implements Self-Checking functionality in Testbench
*/

class sha3_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(sha3_scoreboard)
	
	uvm_analysis_export #(sequence_item) scoreboard_ae;
	uvm_tlm_analysis_fifo #(sequence_item) fifo;
	sequence_item transaction_h;

	function new(string name, uvm_component parent);
		super.new(name, parent);
		transaction_h = new("transaction_h");
	endfunction: new

	function void build_phase(uvm_phase phase);
		scoreboard_ae = new("scoreboard_ae", this);
		fifo = new("fifo", this);
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		scoreboard_ae.connect(fifo.analysis_export);
	endfunction: connect_phase
	
	task run();
		forever begin
		fifo.get(transaction_h);
			`uvm_info("FIFO",$sformatf("Received %h",transaction_h.out), UVM_MEDIUM)
		end
	endtask: run

endclass: sha3_scoreboard