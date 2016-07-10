/**********************************************************
 Start Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Slave Sequence Library
 Filename: ahb_sseqs.svh
**********************************************************/

class ahb_sbase_seq extends uvm_sequence#(ahb_sxtn);

        `uvm_object_utils(ahb_sbase_seq)


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_sbase_seq");

endclass: ahb_sbase_seq

        //Constructor
        function ahb_sbase_seq::new(string name = "ahb_sbase_seq");
                super.new(name);
        endfunction


//--------------------------------------------------------------
// RESET HREADY Seq
//--------------------------------------------------------------

class ahb_reset_sseq extends ahb_sbase_seq;

        `uvm_object_utils(ahb_reset_sseq)

        //-----------------------------------------------
        // Methods
        //-----------------------------------------------

        extern function new(string name = "ahb_reset_sseq");
        extern task body();

endclass: ahb_reset_sseq

        //Constructor
        function ahb_reset_sseq::new(string name = "ahb_reset_sseq");
                super.new(name);
        endfunction

        //Body
        task ahb_reset_sseq::body();
                req = ahb_sxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with { ready.size == 2;} )
                        req.ready = '{1, 1};
                finish_item(req);
        endtask


//--------------------------------------------------------------
// HREADY Seq
//--------------------------------------------------------------

class ahb_ready_sseq extends ahb_sbase_seq;

        `uvm_object_utils(ahb_ready_sseq)


        //-----------------------------------------------
        // Methods
        //-----------------------------------------------

        extern function new(string name = "ahb_ready_sseq");
        extern task body();

endclass: ahb_ready_sseq

        //Constructor
        function ahb_ready_sseq::new(string name = "ahb_ready_sseq");
                super.new(name);
        endfunction

        //Body
        task ahb_ready_sseq::body();
                req = ahb_sxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {response == OKAY;});
                finish_item(req);
        endtask


//--------------------------------------------------------------
// ERROR Response Seq
//--------------------------------------------------------------

class ahb_err_sseq extends ahb_sbase_seq;

        `uvm_object_utils(ahb_err_sseq)


        //-----------------------------------------------
        // Methods
        //-----------------------------------------------

        extern function new(string name = "ahb_err_sseq");
        extern task body();

endclass: ahb_err_sseq

        //Constructor
        function ahb_err_sseq::new(string name = "ahb_err_sseq");
                super.new(name);
        endfunction

        //Body
        task ahb_err_sseq::body();
                req = ahb_sxtn::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {response == ERROR;} );
                finish_item(req);
        endtask

