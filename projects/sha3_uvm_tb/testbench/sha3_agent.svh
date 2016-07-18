/*
	Description: Agent class in UVM environment.
	Author: Mayur Kubavat
	Date: 20 Feb 2015
	Purpose:
	-> Connects Driver to Sequencer using seq_item_port/export,
	-> Connects Monitor Analysis Port to Agent Analysis Port,
	which will be connected to Score Board Analysis Export.
*/

class sha3_agent extends uvm_agent;
   
   `uvm_component_utils(sha3_agent)

   sha3_agent_config sha3_agent_config_h;
   
   sha3_driver driver;
   sha3_read_monitor read_monitor;
   sha3_write_monitor write_monitor;

   sequencer sequencer_h;

   uvm_analysis_port#(sequence_item) agent_ap;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

	function void build_phase(uvm_phase phase);
	
		if(!uvm_config_db #(sha3_agent_config)::get(this, "","config", sha3_agent_config_h))
			`uvm_fatal("AGENT", "Failed to get config object");
			
		is_active = sha3_agent_config_h.get_is_active();
	   
		if (get_is_active() == UVM_ACTIVE) begin
			sequencer_h = sequencer::type_id::create("sequencer_h", this);
			driver = sha3_driver::type_id::create("driver", this);
		end
	
		agent_ap = new("agent_ap", this);

		read_monitor = sha3_read_monitor::type_id::create("read_monitor", this);
		write_monitor = sha3_write_monitor::type_id::create("write_monitor", this);
		
   endfunction: build_phase

   function void connect_phase(uvm_phase phase);
		if (get_is_active() == UVM_ACTIVE) begin
			driver.seq_item_port.connect(sequencer_h.seq_item_export);
		end
		read_monitor.read_monitor_ap.connect(agent_ap);
		write_monitor.write_monitor_ap.connect(agent_ap);
   endfunction: connect_phase

endclass: sha3_agent
