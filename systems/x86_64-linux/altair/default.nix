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

    security.yubikey-u2f = enabled;

    desktop.wayland.common = {
      gpu = "amd";
      uiScaling = "normal";
    };
  };

  system.stateVersion = "22.11";
}

