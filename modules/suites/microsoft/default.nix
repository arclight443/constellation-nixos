{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.suites.microsoft;
  apps = {
    #microsoft-edge = enabled;
  };

in
{
  options.constellation.suites.microsoft = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable Microsoft apps for work.";
  };

  config = mkIf cfg.enable { constellation = { inherit apps; }; };
}
