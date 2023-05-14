{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.krita;

in
{
  options.constellation.apps.krita = with types; {
    enable = mkBoolOpt false "Whether or not to enable krita.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      krita
    ];
  };
}
