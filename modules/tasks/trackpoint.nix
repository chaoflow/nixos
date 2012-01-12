{ config, pkgs, ... }:

with pkgs.lib;

{
  ###### interface

  options = {
  
    trackpoint.sensitivity = mkOption {
      default = "";
      example = "255";
      description = ''
        Configure the trackpoint sensitivity. By default, the kernel
        configures "128".
      '';
    };
    
  };


  ###### implementation

  config = mkIf (config.trackpoint.sensitivity != "") {

    jobs.trackpoint =
      { description = "Initialize trackpoint";

        startOn = "started udev";

        task = true;

        script = ''
          echo -n ${config.trackpoint.sensitivity} \
            > /sys/devices/platform/i8042/serio1/sensitivity
        '';
      };
      
  };

}
