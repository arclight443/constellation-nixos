{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.mpv;

in
{
  options.constellation.apps.mpv = with types; {
    enable = mkBoolOpt false "Whether or not to enable mpv.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mpv
    ];
  };
}
