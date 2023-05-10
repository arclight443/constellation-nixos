{ options, config, lib, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.system.xkb;
in
{
  options.constellation.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "us,th,jp";
      xkbOptions = "caps:escape";
    };
  };
}
