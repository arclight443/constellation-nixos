{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.hardware.laptop.tabletpc;
in
{
  options.constellation.hardware.laptop.tabletpc = with types; {
    enable = mkBoolOpt false "Whether or not to enable tablet PC utilities";
  };

  config = mkIf cfg.enable {

    hardware.sensor.iio.enable = true;
    services.acpid.enable = true;
    services.gnome.at-spi2-core.enable = true;
    constellation.desktop.utils.onboard = enabled;

  };

}
