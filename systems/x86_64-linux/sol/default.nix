{ pkgs, lib, ... }:

with lib;
with lib.internal;
{
  imports = [ ./hardware.nix ];

  constellation = {
    archetypes = {
      workstation = enabled;
    };

    desktop.addons.x11.gpu = "nvidia";
  };

  system.stateVersion = "22.11";
}

