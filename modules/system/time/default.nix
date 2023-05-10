{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.system.time;
in
{
  options.constellation.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable { time.timeZone = "Asia/Bangkok"; };
}
