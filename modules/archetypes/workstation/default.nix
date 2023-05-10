{ options, config, lib, pkgs, ... }:
with lib;
with lib.internal;
let cfg = config.constellation.archetypes.workstation;
in
{
  options.constellation.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    constellation = {
      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
      };

    };
  };
}
