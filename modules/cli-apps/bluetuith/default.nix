inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.cli-apps.bluetuith;
in
{
  options.constellation.cli-apps.bluetuith = with types; {
    enable = mkBoolOpt false "Whether or not to enable bluetuith.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bluetuith
    ];

    constellation.home.configFile = {
      "bluetuith/config" = {
        enable = true;
        text = ''
          set-theme=comfy
          #receive-dir="/home/${config.constellation.user.name}/Received"
        '';
      };
      "bluetuith/themes/comfy" = {
        enable = true;
        text = ''
          Adapter=red
          Device=white
          DeviceConnected=green
          DeviceDiscovered=blue
          DeviceProperty=white
          DevicePropertyConnected=white
          DevicePropertyDiscovered=blue
          Background=transparent
          Border=white
          Menu=white
          MenuItem=purple
        '';

      };
    };
  };
}
