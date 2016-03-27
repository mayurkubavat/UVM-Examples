class apb_env_config extends uvm_object;

    `uvm_object_utils(apb_env_config)

    virtual apb_if m_apb_if;

    bit has_coverage;


    //
    //Methods
    //

    //Constructor
    function new(string name = "apb_env_config");
        super.new(name);
    endfunction //new

endclass //apb_env_config

