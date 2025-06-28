class apb_xtn extends uvm_sequence_item;


    rand bit [31:0] apb_address;

    rand bit [31:0] apb_wr_data;
    rand bit [31:0] apb_rd_data;

    bit [3:0] apb_strobe;

    bit apb_enable;
    int unsigned apb_en_delay;

    bit apb_ready;
    bit apb_completer_err;

    typedef enum{APB_READ, APB_WRITE} apb_rd_wr_e;

    rand apb_rd_wr_e apb_rd_wr;

    rand bit[2:0] apb_prot;

    `uvm_object_utils_begin(apb_xtn)

        `uvm_field_int(apb_address, UVM_DEFAULT)
        `uvm_field_int(apb_wr_data, UVM_DEFAULT)
        `uvm_field_int(apb_rd_data, UVM_DEFAULT)
        `uvm_field_int(apb_enable, UVM_DEFAULT)
        `uvm_field_int(apb_strobe, UVM_DEFAULT)
        `uvm_field_int(apb_ready, UVM_DEFAULT)
        `uvm_field_int(apb_completer_err, UVM_DEFAULT)
        `uvm_field_int(apb_prot, UVM_DEFAULT)

        `uvm_field_enum(apb_rd_wr_e, apb_rd_wr, UVM_DEFAULT)

    `uvm_object_utils_end

    //
    //Methods
    //

    //Constructor
    function new(string name = "apb_xtn");
        super.new(name);
    endfunction //new



    //
    //Constraints
    //



endclass //apb_xtn
