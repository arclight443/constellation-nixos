{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.imv;

in
{
  options.constellation.apps.imv = with types; {
    enable = mkBoolOpt false "Whether or not to enable imv.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      imv
    ];
  };
}
