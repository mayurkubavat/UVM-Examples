//
// APB Initial Test to check environment
// Integrity and Basic Bus transaction checks
//
// Date: 27/03/2016
// Author: Mayur Kubavat
//

class apb_init_test extends apb_base_test;

    `uvm_component_utils(apb_init_test)


    //
    //Methods
    //

    //Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    //Build
    function void buil_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction //build_phase

    task run_phase(uvm_phase phase);

        phase.raise_objection(this);
        #10;
        phase.drop_objection(this);

    endtask //run_phase

endclass //apb_init_test

