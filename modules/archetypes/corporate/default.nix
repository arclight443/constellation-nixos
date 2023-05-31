{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.archetypes.corporate;
in
{
  options.constellation.archetypes.corporate = with types; {
    enable = mkBoolOpt false "Whether or not to enable the corporate software.";
  };

  config = mkIf cfg.enable {
    constellation.suites = {
      microsoft = enabled;
    };
  };
}
