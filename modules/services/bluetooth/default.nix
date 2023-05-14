{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.services.bluetooth;

in
{
  options.constellation.services.bluetooth = with types; {
    enable = mkBoolOpt false "Whether or not to enable bluetooth.";
  };

  config = mkIf cfg.enable {
    services.blueman.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

  };
}
