{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.nmapplet;

in
{
  options.constellation.desktop.utils.nmapplet = with types; {
    enable = mkBoolOpt false "Whether or not to enable nmapplet.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      networkmanagerapplet
    ];

  };
}
