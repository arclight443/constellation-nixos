{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.security.physlock;

in
{
  options.constellation.security.physlock = with types; {
    enable = mkBoolOpt false "Whether or not to enable physlock.";
  };

  config = mkIf cfg.enable {
    services.physlock = {
      enable = true;
      lockOn.suspend = true;
      lockMessage = "Screen locked.";
    };

  };
}
