/*****************************************************************
 * Filename: env.svh
 * Class Name: env
 * Author: Mayur
 * Creation Date: 6 Aug 2015
 * Completion Date:___ Aug 2015
 * --------------------------------------------------------------
 *  -> Contains Virtual Sequencer, Test Configuration, Scoreboard,
 *  AHB Agent(Master Agent), APB Agent(Slave Agent)
 *  -> Local Configuration Properties
 * **************************************************************/

class env extends uvm_env;

	//Register Component to UVM Factory
	`uvm_component_utils(env)
	
	//Configuration Handle and Properties
	env_config cfg_h;
	ahb_agent_config ahb_cfg_h;
	apb_agent_config apb_cfg_h;

	bit has_scoreboard;
	bit has_vsequencer;

	//Handle for AHP & APB Agents
	ahb_agent ahb_agent_h;
	apb_agent apb_agent_h;

	//Handle for Scoreboard and Virtual Sequencer
	scoreboard scoreboard_h;
	vsequencer vsequencer_h;

	//-------------------------------------------
	// Methods
	// ------------------------------------------
	extern function new(string name = "env", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern function void end_of_elaboration_phase(uvm_phase phase);

endclass: env

//Constructor
function env::new(string name = "env", uvm_component parent);
	super.new(name, parent);
endfunction //new

//Build Phase
function void env::build_phase(uvm_phase phase);
	//Get Configuration Object from Database
	if(!uvm_config_db#(env_config)::get(this, "", "env_config", cfg_h))
		`uvm_fatal("ENV", "Cannot get configuration object from database")

	
	//Set Configuration Parameters from Object
	has_scoreboard = cfg_h.has_scoreboard;	
	has_vsequencer = cfg_h.has_vsequencer;	
	
	//Create and Set Agent Configuration Object
	ahb_cfg_h = ahb_agent_config::type_id::create("ahb_cfg_h");
	apb_cfg_h = apb_agent_config::type_id::create("apb_cfg_h");

	ahb_cfg_h.vif = cfg_h.ahb_vif;
	apb_cfg_h.vif = cfg_h.apb_vif; 

	uvm_config_db#(ahb_agent_config)::set(this, "*ahb_agent_h.*", "ahb_agent_config", ahb_cfg_h);
	uvm_config_db#(apb_agent_config)::set(this, "*apb_agent_h.*", "apb_agent_config", apb_cfg_h);
	
	super.build_phase(phase);
	
	//Create AHB Agent
	ahb_agent_h = ahb_agent::type_id::create("ahb_agent_h", this);
	//Create APB Agent
	apb_agent_h = apb_agent::type_id::create("apb_agent_h", this);

	if(has_scoreboard)
	begin
		//Create Scoreboard
		scoreboard_h = scoreboard::type_id::create("scoreboard", this);
	end
	
	if(has_vsequencer)
	begin
		//Create Virtual Sequencer
		vsequencer_h = vsequencer::type_id::create("vsequencer_h", this);
	end
endfunction //build_phase

//Connect Phase
function void env::connect_phase(uvm_phase phase);
	if(has_scoreboard)
	begin
		//Connect AHB Monitor AP to Scoreboard FIFO Analysis Export
		ahb_agent_h.ahb_monitor_h.monitor_ap.connect(scoreboard_h.fifo_ahb.analysis_export);
		//Connect APB Monitor AP to Scoreboard FIFO Analysis Export
		apb_agent_h.apb_monitor_h.monitor_ap.connect(scoreboard_h.fifo_apb.analysis_export);
	end

	if(has_vsequencer)
	begin
		//Connect Virtual Sequencer's AHB Sequencer to the Agent AHB
		//Sequencer
		vsequencer_h.ahb_sequencer_h = ahb_agent_h.ahb_sequencer_h;
	end
endfunction //connect_phase

function void env::end_of_elaboration_phase(uvm_phase phase);
	`uvm_info("ENV", {get_full_name(), " Created.."}, UVM_MEDIUM)
endfunction //end_of_elaboration
