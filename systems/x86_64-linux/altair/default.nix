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

    desktop.x11.common = {
      gpu = "amd";
      uiScaling = "normal";
      autoRotate = {
        enable = true;
        touchDevice = "Wacom HID 52AE Pen Pen (0x802026b9)";
      };
    };
  };

  system.stateVersion = "22.11";
}

