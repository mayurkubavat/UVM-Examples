/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 12 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Virtual Sequence Library
 Filename: ahb_vseqs.svh
**********************************************************/

class ahb_base_vseq extends uvm_sequence#(uvm_sequence_item);

        `uvm_object_utils(ahb_base_vseq)

        ahb_vseqr vseqr_h;
        ahb_mseqr mseqr_h;
        ahb_sseqr sseqr_h;
        reset_seqr reset_seqr_h;

        reset_seq reset_seq_h;
        set_seq set_seq_h;

        ahb_idle_mseq idle_mseq_h;
        ahb_incrx_mseq incrx_mseq_h;
        ahb_wrapx_mseq wrapx_mseq_h;
        ahb_crt_mseq crt_mseq_h;
        ahb_incrbusy_mseq incrbusy_mseq_h;

        ahb_reset_sseq reset_sseq_h;
        ahb_ready_sseq ready_sseq_h;
        ahb_err_sseq err_sseq_h;


        //------------------------------------------------
        // Methods
        //------------------------------------------------

        extern function new(string name = "ahb_base_vseq");
        extern task body();

endclass: ahb_base_vseq

        //Constructor
        function ahb_base_vseq::new(string name = "ahb_base_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_base_vseq::body();
                if(!$cast(vseqr_h, m_sequencer))
                begin
                        `uvm_fatal(get_full_name(), "Virtual Sequencer cast failed!")
                end

                reset_seqr_h = vseqr_h.reset_seqr_h;
                mseqr_h = vseqr_h.mseqr_h;
                sseqr_h = vseqr_h.sseqr_h;
        endtask


//----------------------------------------------------------
// Reset
//----------------------------------------------------------

class ahb_reset_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_reset_vseq)


        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_reset_vseq");
        extern task body();

endclass: ahb_reset_vseq

        //Constructor
        function ahb_reset_vseq::new(string name = "ahb_reset_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_reset_vseq::body();
                super.body();

                reset_seq_h = reset_seq::type_id::create("reset_seq_h");
                reset_sseq_h = ahb_reset_sseq::type_id::create("reset_sseq_h");

                fork
                        reset_sseq_h.start(sseqr_h);
                join_none

                reset_seq_h.start(reset_seqr_h);

        endtask


//----------------------------------------------------------
// Set
//----------------------------------------------------------

class ahb_set_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_set_vseq)

        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_set_vseq");
        extern task body();

endclass: ahb_set_vseq

        //Constructor
        function ahb_set_vseq::new(string name = "ahb_set_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_set_vseq::body();
                super.body();

                set_seq_h = set_seq::type_id::create("set_seq_h");

                set_seq_h.start(reset_seqr_h);

        endtask


//----------------------------------------------------------
// IDLE
//----------------------------------------------------------

class ahb_idle_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_idle_vseq)

        //----------------------------------------------
        // Methods
        //----------------------------------------------
        extern function new(string name = "ahb_idle_vseq");
        extern task body();

endclass: ahb_idle_vseq

        //Constructor
        function ahb_idle_vseq::new(string name = "ahb_idle_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_idle_vseq::body();
                super.body();

                idle_mseq_h = ahb_idle_mseq::type_id::create("idle_mseq_h");

                idle_mseq_h.start(mseqr_h);
        endtask


//----------------------------------------------------------
// Ready
//----------------------------------------------------------

class ahb_ready_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_ready_vseq)

        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_ready_vseq");
        extern task body();

endclass: ahb_ready_vseq
        //Constructor
        function ahb_ready_vseq::new(string name = "ahb_ready_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_ready_vseq::body();
                super.body();

                ready_sseq_h = ahb_ready_sseq::type_id::create("ready_sseq_h");

                ready_sseq_h.start(sseqr_h);
        endtask



//----------------------------------------------------------
// INCRx
//----------------------------------------------------------

class ahb_incrx_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_incrx_vseq)


        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_incrx_vseq");
        extern task body();

endclass: ahb_incrx_vseq

        //Constructor
        function ahb_incrx_vseq::new(string name = "ahb_incrx_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_incrx_vseq::body();
                super.body();

                incrx_mseq_h = ahb_incrx_mseq::type_id::create("incrx_mseq_h");

                incrx_mseq_h.start(mseqr_h);
        endtask


//----------------------------------------------------------
// WRAPx
//----------------------------------------------------------

class ahb_wrapx_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_wrapx_vseq)


        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_wrapx_vseq");
        extern task body();

endclass: ahb_wrapx_vseq

        //Constructor
        function ahb_wrapx_vseq::new(string name = "ahb_wrapx_vseq");
                super.new(name);
        endfunction
        //Body
        task ahb_wrapx_vseq::body();
                super.body();

                wrapx_mseq_h = ahb_wrapx_mseq::type_id::create("wrapx_mseq_h");

                wrapx_mseq_h.start(mseqr_h);
        endtask



//----------------------------------------------------------
// CRT
//----------------------------------------------------------

class ahb_crt_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_crt_vseq)


        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_crt_vseq");
        extern task body();

endclass: ahb_crt_vseq

        //Constructor
        function ahb_crt_vseq::new(string name = "ahb_crt_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_crt_vseq::body();
                super.body();

                crt_mseq_h = ahb_crt_mseq::type_id::create("crt_mseq_h");

                crt_mseq_h.start(mseqr_h);
        endtask


//----------------------------------------------------------
// INCR - BUSY
//----------------------------------------------------------

class ahb_incrbusy_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_incrbusy_vseq)


        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_incrbusy_vseq");
        extern task body();

endclass: ahb_incrbusy_vseq

        //Constructor
        function ahb_incrbusy_vseq::new(string name = "ahb_incrbusy_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_incrbusy_vseq::body();
                super.body();

                incrbusy_mseq_h = ahb_incrbusy_mseq::type_id::create("incrbusy_mseq_h");
                incrbusy_mseq_h.start(mseqr_h);
        endtask


//----------------------------------------------------------
// ERR
//----------------------------------------------------------

class ahb_err_vseq extends ahb_base_vseq;

        `uvm_object_utils(ahb_err_vseq)


        //----------------------------------------------
        // Methods
        //----------------------------------------------

        extern function new(string name = "ahb_err_vseq");
        extern task body();

endclass: ahb_err_vseq

        //Constructor
        function ahb_err_vseq::new(string name = "ahb_err_vseq");
                super.new(name);
        endfunction

        //Body
        task ahb_err_vseq::body();
                super.body();

                err_sseq_h = ahb_err_sseq::type_id::create("err_sseq_h");

                err_sseq_h.start(sseqr_h);
        endtask

