/**********************************************************
 Start Date: 22 Sept 2015
 Finish Date: 22 Sept 2015
 Author: Mayur Kubavat
 
 Module: Reset Sequence
 Filename: reset_seqs.svh
**********************************************************/

class reset_base_seq extends uvm_sequence#(ahb_mxtn);

        `uvm_object_utils(reset_base_seq)

        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "reset_base_seq");

endclass: reset_base_seq

        //Constructor
        function reset_base_seq::new(string name = "reset_base_seq");
                super.new(name);
        endfunction


//---------------------------------------------------------------
// Assert Reset Sequence
//---------------------------------------------------------------

class reset_seq extends reset_base_seq;

        `uvm_object_utils(reset_seq)


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "reset_seq");
        extern task body();

endclass: reset_seq

        //Constructor
        function reset_seq::new(string name = "reset_seq");
                super.new(name);
        endfunction

        //Body
        task reset_seq::body();
                req = ahb_mxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {burst_mode == SINGLE;});
                        req.reset = 0;
                finish_item(req);
        endtask


//---------------------------------------------------------------
// De-assert Sequence
//---------------------------------------------------------------

class set_seq extends reset_base_seq;

        `uvm_object_utils(set_seq)


        //------------------------------------------------
        // Methods
        //------------------------------------------------
        extern function new(string name = "set_seq");
        extern task body();

endclass: set_seq

        //Constructor
        function set_seq::new(string name = "set_seq");
                super.new(name);
        endfunction

        //Body
        task set_seq::body();
                req = ahb_mxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {burst_mode == SINGLE;});
                        req.reset = 1;
                finish_item(req);
        endtask

