RTL = ../rtl/*
INC = +incdir+../rtl +incdir+../ahb_agent_top +incdir+../apb_agent_top +incdir+../test +incdir+../env 
SVTB =  ../env/top.sv
INTF = ../rtl/*.sv
SVTB1 = ../test/test_pkg.sv
work = work

VSIMOPT= -novopt -sva -sv_seed random -l s.log work.top

VSIMBATCH1 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov1;run -all;exit"
VSIMBATCH2 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov2;run -all;exit"
VSIMBATCH3 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov3;run -all;exit"
VSIMBATCH4 = -c -do "coverage save -onexit -assert -directive -cvg -codeAll cov4;run -all;exit"

html:
	firefox covhtmlreport/pages/__frametop.htm

lib:
	vlib $(work)
	vmap work $(work)

sv_cmp: lib comp0
         
run_sim:
	vsim $(VSIMOPT) $(VSIMBATCH1)    
	vcover report -html cov1

gui:
	vsim $(VSIMOPT) -coverage +UVM_OBJECTION_TRACE +UVM_TESTNAME=reset_test +UVM_VERBOSITY=UVM_MEDIUM
	vcover report -html cov1
	
comp0:
	vlog -work $(work) $(INTF) $(INC) $(SVTB1) $(SVTB)

run_gui: clean lib comp0 gui

run_test: lib comp0
	vsim  $(VSIMBATCH1) -coverage -novopt -sva -sv_seed random -l test1_sim.log work.top +UVM_OBJECTION_TRACE +UVM_TESTNAME=reset_test +UVM_VERBOSITY=UVM_MEDIUM
	vcover report -html cov1

run_test1:
	vsim  $(VSIMBATCH2) -coverage -novopt -sva -sv_seed random -l test2_sim.log work.top +UVM_OBJECTION_TRACE +UVM_TESTNAME=ram_ten_addr_test +UVM_VERBOSITY=UVM_MEDIUM #The Default Verbosity is medium
	vcover report -html mem_cov2

run_test2:
	vsim  $(VSIMBATCH3) -coverage -novopt -sva -sv_seed random -l test3_sim.log work.top +UVM_OBJECTION_TRACE +UVM_TESTNAME=ram_odd_addr_test +UVM_VERBOSITY=UVM_MEDIUM #The Default Verbosity is medium
	vcover report -html mem_cov3

run_test3:
	vsim  $(VSIMBATCH4) -coverage -novopt -sva -sv_seed random -l test4_sim.log work.top +UVM_OBJECTION_TRACE +UVM_TESTNAME=ram_even_addr_test +UVM_VERBOSITY=UVM_MEDIUM #The Default Verbosity is medium
	vcover report -html mem_cov4

clean:
	rm -rf modelsim.* transcript* *log* work vsim.wlf fcover* covhtml* mem_cov*
	clear
report:
	vcover merge mem_cover mem_cov1 mem_cov2 mem_cov3 mem_cov4
	vcover report -html mem_cover

regress: clean run_test run_test1 run_test2 run_test3 report html
