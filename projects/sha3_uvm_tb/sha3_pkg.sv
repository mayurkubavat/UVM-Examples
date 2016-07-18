package sha3_pkg;

// Include Package Items and Macros
import uvm_pkg::*;
`include "uvm_macros.svh"

// Define Sequencer, Include Sequence Items   
`include "sequence_item.svh"
typedef uvm_sequencer#(sequence_item) sequencer;

// Sequences
`include "sequences/base_sequence.svh"
`include "sequences/reset_seq.svh"
`include "sequences/init_seq.svh"
`include "sequences/strt_ctrl_seq.svh"
`include "sequences/finish_ctrl_seq.svh"
`include "sequences/msg_seq.svh"
`include "sequences/empty_msg_seq.svh"
`include "sequences/rndmsg_seq.svh"
`include "sequences/long_msg_seq.svh"
`include "sequences/tr1_seq.svh"
`include "sequences/tr2_seq.svh"
`include "sequences/tr3_seq.svh"
`include "sequences/tr5_seq.svh"

// UVM Components
`include "sha3_driver.svh"
`include "sha3_write_monitor.svh"
`include "sha3_read_monitor.svh"
`include "sha3_agent_config.svh"
`include "sha3_agent.svh"
`include "sha3_scoreboard.svh"
`include "sha3_coverage.svh"
`include "sha3_env.svh"

// Base Test and Extended Tests 
`include "test/sha3_base_test.svh"
`include "test/tr1_test.svh"
`include "test/tr2_test.svh"
`include "test/tr3_test.svh"
`include "test/tr5_test.svh"

endpackage: sha3_pkg
