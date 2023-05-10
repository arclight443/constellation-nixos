{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.jumpapp;

in
{
  options.constellation.desktop.addons.jumpapp = with types; {
    enable = mkBoolOpt false "Whether or not to enable Jumpapp.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jumpapp
    ];

  };
}
