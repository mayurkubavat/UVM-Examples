class base_sequence extends uvm_sequence #(uvm_sequence_item);
   `uvm_object_utils(base_sequence);

	sequencer sequencer_h;
	uvm_component uvm_component_h;
	
	function new(string name = "");
		super.new(name);
	
	//Create uvm_component, hand over sequencer from our env
	// and cast it to sequencer handle.
    uvm_component_h =  uvm_top.find("*.env_h.agent.sequencer_h");
    
	if (uvm_component_h == null)
		`uvm_fatal("RUNALL SEQUENCE", "Failed to get the sequencer")
    
	if (!$cast(sequencer_h, uvm_component_h))
		`uvm_fatal("RUNALL SEQUENCE", "Failed to cast from uvm_component_h.")
    
	endfunction : new

	task body();
	endtask : body

endclass : base_sequence