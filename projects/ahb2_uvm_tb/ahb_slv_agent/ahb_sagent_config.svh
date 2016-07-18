/**********************************************************
 Start Date: 10 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Slave Agent Configuration
 Filename: ahb_sagent_config.svh
**********************************************************/

class ahb_sagent_config extends uvm_object;

        `uvm_object_utils(ahb_sagent_config)

        virtual ahb_intf vif;

        uvm_active_passive_enum is_active;


        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "ahb_sagent_config");

endclass: ahb_sagent_config

        //Constructor
        function ahb_sagent_config::new(string name = "ahb_sagent_config");
                super.new(name);
        endfunction

