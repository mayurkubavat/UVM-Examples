/*
	Description: Env class in UVM environment.
	Author: Mayur Kubavat
	Date: 22 Feb 2015
	Purpose:
	-> Extends uvm_env base class,
	-> Conects Agent to Score Board via Analysis Port/Export.
*/

class sha3_env extends uvm_env;

	`uvm_component_utils(sha3_env)

	sha3_agent agent;
	sha3_agent_config config_h;
	
	sha3_scoreboard scoreboard;
	sha3_coverage coverage;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		
		config_h = new(UVM_ACTIVE);
		uvm_config_db #(sha3_agent_config)::set(this, "agent", "config", config_h);
		
		agent = sha3_agent::type_id::create("agent", this);
		
		scoreboard = sha3_scoreboard::type_id::create("scoreboard", this);
		coverage = sha3_coverage::type_id::create("coverage", this);
		
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		agent.agent_ap.connect(scoreboard.scoreboard_ae);
		agent.agent_ap.connect(coverage.analysis_export);
		agent.agent_ap.connect(coverage.analysis_export);
	endfunction: connect_phase

endclass: sha3_env
