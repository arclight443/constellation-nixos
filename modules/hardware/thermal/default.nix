{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.hardware.thermal;
in
{
  options.constellation.hardware.thermal = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable support for thermal status.";
  };

  config = mkIf cfg.enable {
    constellation.user.extraGroups = [ "adm" ];
    environment.systemPackages = with pkgs; [ lm_sensors ];
  };
}
