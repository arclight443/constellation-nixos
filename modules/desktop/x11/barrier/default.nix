{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.x11.barrier;

in
{
  options.constellation.desktop.x11.barrier = with types; {
    enable = mkBoolOpt false "Whether or not to enable Barrier.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      barrier
    ];

    networking.firewall.allowedTCPPorts = [
      24800
    ];

  };
}
