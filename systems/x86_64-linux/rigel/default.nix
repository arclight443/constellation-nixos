{ pkgs, lib, ... }:

with lib;
with lib.internal;
{
  imports = [ ./hardware.nix ];
  constellation = {
    archetypes = {
      workstation = enabled;
      corporate = enabled;
      gaming = enabled;
    };

    hardware.laptop.common = enabled;
    hardware.laptop.tabletpc = enabled;

    desktop.x11.common = {
      gpu = "amd";
      uiScaling = "normal";
    };
  };

  system.stateVersion = "22.11";
}

