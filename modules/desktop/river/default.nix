{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.river;

in
{
  options.constellation.desktop.river = with types; {
    enable = mkBoolOpt false "Whether or not to enable riverwm.";
  };

  config = mkIf cfg.enable {
    constellation = {
      desktop = {
        utils = {
          eww = {
            enable = true;
            display = "wayland";
          };
        };
      };
    };
    environment.systemPackages = with pkgs; [
      river
    ];
  };

}
