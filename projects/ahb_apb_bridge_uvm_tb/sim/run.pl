#!/usr/bin/perl

use warnings;
use strict;


sub main(){

	Init_Variables();

	Compile();

#print "Run the Test No. (e.g. test1, test2, regress etc): ";
#$test_is = <STDIN>;
#chomp($test_is);

	#if($VARG[0] == "test1"){
		RUN_TEST1();
	#}
}

#----------------------------------------
#Variable Definitions
#----------------------------------------
sub Init_Variables(){
	
	# RTL and SV Interfaces
	$RTL = "../rtl/*";

	# TOP SV Module
	$TOP = "../env/top.sv";

	#Package
	$PKG = "../test/test_pkg.sv";

	#Include Dirs
	$INC = "+incdir+../ahb_agent_top +incdir+../apb_agent_top +incdir+../test +incdir+../env";

	$WORK = "work";

	$VSIMOPT = "-novopt -sva -sv_seed random -l s.log work.top";

	$VSIMBATCH1 = "-c -do \"coverage save -onexit -assert -directive -cvg -codeAll cov1; run -all; exit\"";

}


#----------------------------------------
# Compile
#----------------------------------------
sub Compile(){
	system "vlib $WORK";
	system "vmap work $WORK";
}

sub RUN_TEST1(){
	
	system "vsim  $VSIMBATCH1 -coverage -novopt -sva -sv_seed random -l test1_sim.log work.top +UVM_OBJECTION_TRACE +UVM_TESTNAME=reset_test +UVM_VERBOSITY=UVM_MEDIUM";

	system "vcover report -html cov1"
}


main();
