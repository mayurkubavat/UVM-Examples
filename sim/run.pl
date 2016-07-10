#!/urs/bin/env perl

#Use this to write consistant code and to
#avoid any implicit assumptions by perl
#module
use strict;
use warnings;

{
    #If no options provided to command line
    #and to ignore warning messages
    no warnings;
    die "No option. See run.pl -help | -h" if($ARGV[0] eq '');
}

#Provide command-line arguments in a better
#way
use Getopt::Long;

my ($clean, $test_name, $batch_mode, $compile_mode, $gui_mode, $regress);
GetOptions(
    "clean"     => \$clean,
    "test=s"    => \$test_name,
    "batch"     => \$batch_mode,
    "compile"   => \$compile_mode,
    "gui"       => \$gui_mode,
    "regress"   => \$regress
) or die "Invalid option. See run.pl -help | -h";

sub main();
sub library();      #Create and Map library
sub compile();      #Compile
sub run_regress();
sub report();
sub view_browser();
sub run_gui();
sub run_cmd();

my $WORK = "work";

main();



sub main(){

    if(defined $clean){
        clean();
        exit;
    }

    library();      #Create and Map library
    compile();      #Compile

    if(!defined $compile_mode){

        if(defined $regress){
            run_regress();
        }else{

            if(defined $gui_mode){
                run_gui();
            }else{
                run_cmd();
            }
        }
        #report();
        #view_browser();
    }

}

sub library(){
    system "vlib $WORK";
    system "vmap work $WORK";
}



sub compile(){
    system "vlog -work $WORK -f ahb_inc.f";
}



sub run_cmd(){
    my $LOG = $test_name."_sim.log";
    my $COV = $test_name."_cov";

    my $VSIMOPT = "-novopt -assertdebug -sva -sv_seed 16422201 -l $LOG work.top";
    my $VSIMBATCH = "-c -do \"coverage save -onexit -assert -directive -cvg -codeAll $COV; run -all; exit\"";

    system "vsim $VSIMBATCH $VSIMOPT +UVM_TESTNAME=$test_name";
    system "vcover report -html $COV";
}


sub run_regress(){

    open(FR, '<', "testcases.txt") or die "testcases.txt missing! $!";

    while(<FR>){
        chomp($_);

        my $LOG = $_."_sim.log";
        my $COV = $_."_cov";

        my $VSIMOPT = "-novopt -assertdebug -sva -sv_seed 16422201 -l $LOG work.top";
        my $VSIMBATCH = "-c -do \"coverage save -onexit -assert -directive -cvg -codeAll $COV; run -all; exit\"";

        system "vsim $VSIMBATCH $VSIMOPT +UVM_TESTNAME=$_";
        system "vcover report -html $COV";
    }
}


sub report(){
   system "vcover merge cov_final cov?";
   system "vcover report -html cov_final";
}


sub view_browser(){
   system "firefox covhtmlreport/pages/__frametop.htm";

}


sub run_gui(){
    my $LOG = $test_name."_sim.log";
    my $COV = $test_name."_cov";

    my $VSIMOPT = "-novopt -assertdebug -sva -sv_seed 16422201 -l $LOG work.top";
    my $VSIMBATCH = "-c -do \"coverage save -onexit -assert -directive -cvg -codeAll $COV; run -all; exit\"";

    system "vsim $VSIMOPT +UVM_TESTNAME=$test_name";
    system "vcover report -html $COV";
}


sub clean(){
   system "rm -rf modelsim* transcript* *log* work vsim.wlf wlf* fcover* covhtml* *cov";
   system "clear";
}

