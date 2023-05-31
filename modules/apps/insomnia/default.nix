{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.insomnia;

in
{
  options.constellation.apps.insomnia = with types; {
    enable = mkBoolOpt false "Whether or not to enable insomnia.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      insomnia
    ];
  };
}
