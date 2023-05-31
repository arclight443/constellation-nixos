{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.suites.games;
  apps = {
    steam = enabled;
  };

in
{
  options.constellation.suites.games = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common games configuration.";
  };

  config = mkIf cfg.enable { constellation = { inherit apps; }; };
}
