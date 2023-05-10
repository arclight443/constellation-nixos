{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.picom;

in
{
  options.constellation.desktop.addons.picom = with types; {
    enable = mkBoolOpt false "Whether or not to enable picom.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      picom
    ];

  };
}
