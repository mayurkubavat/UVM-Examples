/**********************************************************
 Start Date: 11 Sept 2015
 Finish Date: 11 Sept 2015
 Author: Mayur Kubavat
 
 Module: AHB Environment Configuration
 Filename: env_config.sv
**********************************************************/

class env_config extends uvm_object;

        `uvm_object_utils(env_config)

        ahb_magent_config magt_cfg;
        ahb_sagent_config sagt_cfg;

        uvm_active_passive_enum m_is_active;
        uvm_active_passive_enum s_is_active;

        virtual ahb_intf vif;


        //-------------------------------------------------
        // Methods
        //-------------------------------------------------

        extern function new(string name = "env_config");

endclass: env_config

        //Constructor
        function env_config::new(string name = "env_config");
                super.new(name);
        endfunction

