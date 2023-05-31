{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.hardware.laptop.common;
in
{
  options.constellation.hardware.laptop.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common laptop utilities.";
  };

  config = mkIf cfg.enable {
    # Backlight
    constellation.user.extraGroups = [ "video" ];
    programs.light.enable = true;

    # Physlock
    constellation.security.physlock = enabled;

  };

}
