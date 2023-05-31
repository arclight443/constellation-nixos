{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.archetypes.gaming;
in
{
  options.constellation.archetypes.gaming = with types; {
    enable = mkBoolOpt false "Whether or not to enable the gaming archetype.";
  };

  config = mkIf cfg.enable {
    constellation.suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
    };
  };
}


