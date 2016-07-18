
RTL = ../rtl/*.sv
TOP = ../env/top.sv
PKG = ../test/test_pkg.sv

INC = +incdir+../ahb_magt +incdir+../ahb_sagt +incdir+../env +incdir+../test +incdir+../rtl

WORK = work

VSIMOPT = -novopt -sva -sv_seed random -l s.log work.top


VSIMBATCH1 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov1; run -all; exit"
VSIMBATCH2 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov2; run -all; exit"
VSIMBATCH3 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov3; run -all; exit"
VSIMBATCH4 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov4; run -all; exit"


lib:
        vlib $(WORK)
        vmap work $(WORK)

cmp:
        vlog -work $(WORK) $(INC) $(RTL) $(PKG) $(TOP)

run_gui: clean lib cmp
        vsim -coverage -novopt -sva -sv_seed 3311333501 -l test4_sim.log work.top +UVM_TESTNAME=w4busy_test
        vcover report -html cov

run_test1: clean lib cmp
        vsim $(VSIMBATCH1) -coverage -novopt -sva -sv_seed random -l test1_sim.log work.top +UVM_TESTNAME=reset_test
        vcover report -html cov1

run_test2: clean lib cmp
        vsim $(VSIMBATCH2) -coverage -novopt -sva -sv_seed random -l test2_sim.log work.top +UVM_TESTNAME=inc4_test
        vcover report -html cov2

run_test3: clean lib cmp
        vsim $(VSIMBATCH3) -coverage -novopt -sva -sv_seed random -l test3_sim.log work.top +UVM_TESTNAME=crt_test
        vcover report -html cov3

run_test4: clean lib cmp
        vsim $(VSIMBATCH4) -coverage -novopt -sva -sv_seed random -l test4_sim.log work.top +UVM_TESTNAME=w4busy_test
        vcover report -html cov4
clean: 
        rm -rf modelsim.* transcript* *log* work vsim.wlf vish_* fcover* covhtml* cov*
        clear

