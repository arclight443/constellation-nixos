{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.kitty;

in
{
  options.constellation.desktop.utils.kitty = with types; {
    enable = mkBoolOpt false "Whether or not to enable kitty terminal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];

    constellation.home.configFile."kitty/" = {
      source = ./config;
      recursive = true;
    };

  };
}
