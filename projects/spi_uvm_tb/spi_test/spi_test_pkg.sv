package spi_test_pkg;

	`include "uvm_macros.svh"
	import uvm_pkg::*;

	`include "spi_transaction.svh"

	`include "spi_master_config.svh"
	`include "spi_slave_config.svh"

	`include "spi_env_config.svh"

	`include "spi_seqr.svh"
	
	`include "spi_master_driver.svh"
	`include "spi_master_monitor.svh"
	`include "spi_master_agent.svh"

	`include "spi_slave_driver.svh"
	`include "spi_slave_monitor.svh"
	`include "spi_slave_agent.svh"

	`include "spi_subscriber.svh"

	`include "spi_env.svh"

	`include "spi_base_test.svh"

endpackage //spi_test_pkg
