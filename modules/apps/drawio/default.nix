{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.drawio;

in
{
  options.constellation.apps.drawio = with types; {
    enable = mkBoolOpt false "Whether or not to enable drawio.";
  };

  config = mkIf cfg.enable {

    constellation.home.extraOptions = {
      home.packages = with pkgs; [
        drawio
      ];

    };
  };
}

