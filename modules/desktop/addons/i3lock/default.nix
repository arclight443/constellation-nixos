{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.i3lock;

in
{
  options.constellation.desktop.addons.i3lock = with types; {
    enable = mkBoolOpt false "Whether or not to enable i3lock.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      i3lock-color
    ];

    constellation.home.extraOptions = {
      home.packages = with pkgs; [
        (buildEnv { name = "scripts"; path = [ ./scripts ]; })
      ];
    };

  };
}
