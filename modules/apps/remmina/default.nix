{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.remmina;

in
{
  options.constellation.apps.remmina = with types; {
    enable = mkBoolOpt false "Whether or not to enable remmina.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      remmina
    ];
  };
}
