/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Master Agent Configuration
 Filename: ahb_magent_config.svh
**********************************************************/

class ahb_magent_config extends uvm_object;

        `uvm_object_utils(ahb_magent_config)

        virtual ahb_intf vif;
        uvm_active_passive_enum is_active;


        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "ahb_magent_config");

endclass: ahb_magent_config

        //Constructor
        function ahb_magent_config::new(string name = "ahb_magent_config");
                super.new(name);
        endfunction

