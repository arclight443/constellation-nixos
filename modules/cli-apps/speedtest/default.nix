{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.cli-apps.speedtest;

in
{
  options.constellation.cli-apps.speedtest = with types; {
    enable = mkBoolOpt false "Whether or not to enable speedtest.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ookla-speedtest
    ];

  };
}
