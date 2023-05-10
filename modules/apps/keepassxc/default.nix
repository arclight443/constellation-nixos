{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.keepassxc;

in
{
  options.constellation.apps.keepassxc = with types; {
    enable = mkBoolOpt false "Whether or not to enable keepassxc.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      keepassxc
    ];
  };
}
