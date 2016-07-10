/**********************************************************
 Start Date: 10 Sept 2015
 Finish Date: 18 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master Sequence Library
 Filename: ahb_mseqs.svh
**********************************************************/

class ahb_mbase_seq extends uvm_sequence#(ahb_mxtn);

        `uvm_object_utils(ahb_mbase_seq)


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_mbase_seq");

endclass: ahb_mbase_seq

        //Constructor
        function ahb_mbase_seq::new(string name = "ahb_mbase_seq");
                super.new(name);
        endfunction



//------------------------------------------------------------
// Idle Sequence
//------------------------------------------------------------

class ahb_idle_mseq extends ahb_mbase_seq;

        `uvm_object_utils(ahb_idle_mseq)
        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_idle_mseq");
        extern task body();

endclass: ahb_idle_mseq

        //Constructor
        function ahb_idle_mseq::new(string name = "ahb_idle_mseq");
                super.new(name);
        endfunction

        //Body
        task ahb_idle_mseq::body();
                req = ahb_mxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with { ((burst_mode == 0) && (trans_type[0] == 0)); } );
                finish_item(req);
        endtask



//------------------------------------------------------------
// 4, 8 and 16 Beat Wrap Mode (WRAPx) Sequence
//------------------------------------------------------------

class ahb_wrapx_mseq extends ahb_mbase_seq;

        `uvm_object_utils(ahb_wrapx_mseq)

        //------------------------------------------------
        // Methods
        //------------------------------------------------
        extern function new(string name = "ahb_wrapx_mseq");
        extern task body();

endclass: ahb_wrapx_mseq

        //Constructor
        function ahb_wrapx_mseq::new(string name = "ahb_wrapx_mseq");
                super.new(name);
        endfunction

        //Body
        task ahb_wrapx_mseq::body();
                req = ahb_mxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {((burst_mode == WRAP4)||(burst_mode == WRAP8)||(burst_mode == WRAP16));} );
                finish_item(req);
        endtask


//------------------------------------------------------------
// 4, 8 and 16 Beat Length Increments (INCRx) Sequence
//------------------------------------------------------------

class ahb_incrx_mseq extends ahb_mbase_seq;

        `uvm_object_utils(ahb_incrx_mseq)

        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_incrx_mseq");
        extern task body();

endclass: ahb_incrx_mseq

        //Constructor
        function ahb_incrx_mseq::new(string name = "ahb_incrx_mseq");
                super.new(name);
        endfunction

        //Body
        task ahb_incrx_mseq::body();
                req = ahb_mxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {((burst_mode == INCR4)||(burst_mode == INCR8)||(burst_mode == INCR16));} );
                finish_item(req);
        endtask


//------------------------------------------------------------
// Constraint Random Sequence
//------------------------------------------------------------

class ahb_crt_mseq extends ahb_mbase_seq;

        `uvm_object_utils(ahb_crt_mseq)

        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_crt_mseq");
        extern task body();

endclass: ahb_crt_mseq

        //Constructor
        function ahb_crt_mseq::new(string name = "ahb_crt_mseq");
                super.new(name);
        endfunction
        //Body
        task ahb_crt_mseq::body();
                req = ahb_mxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {address.size < 20;} );
                finish_item(req);
        endtask


//------------------------------------------------------------
// Unspecified Length INCR with 1 Busy
//------------------------------------------------------------

class ahb_incrbusy_mseq extends ahb_mbase_seq;

        `uvm_object_utils(ahb_incrbusy_mseq)

        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_incrbusy_mseq");
        extern task body();

endclass: ahb_incrbusy_mseq

//Constructor
function ahb_incrbusy_mseq::new(string name = "ahb_incrbusy_mseq");
        super.new(name);
endfunction

//Body
task ahb_incrbusy_mseq::body();
        req = ahb_mxtn::type_id::create("req");
        start_item(req);
                assert(req.randomize() with {((burst_mode == INCR)&&(address.size < 20)&&(no_of_busy == 1));} );
        finish_item(req);
endtask
                             
