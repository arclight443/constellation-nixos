{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.cli-apps.miniplayer;
in
{
  options.constellation.cli-apps.miniplayer = with types; {
    enable = mkBoolOpt false "Whether or not to enable miniplayer.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      home.packages = with pkgs; [
        miniplayer
      ];
    };

  };
}

