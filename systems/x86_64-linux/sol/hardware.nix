{ config, lib, pkgs, inputs, modulesPath, ... }:

let
  inherit (inputs) nixos-hardware;
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_1;

    initrd = {
      availableKernelModules =
        [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-partlabel/nixos";
      fsType = "ext4";
    };

    "/boot/efi" = {
      device = "/dev/disk/by-partlabel/boot";
      fsType = "vfat";
    };

    "/mnt/data" = {
      device = "/dev/disk/by-partlabel/data";
      fsType = "auto";
      options = [ "rw" ];
    };

    "/home/${config.constellation.user.name}/Music" = {
      device = "/mnt/data/Media/Music";
      options = [ "bind" "rw" ];
    };

    "/home/${config.constellation.user.name}/Pictures" = {
      device = "/mnt/data/Media/Pictures";
      options = [ "bind" "rw" ];
    };

    "/home/${config.constellation.user.name}/Videos" = {
      device = "/mnt/data/Media/Videos";
      options = [ "bind" "rw" ];
    };

    "/home/${config.constellation.user.name}/Secure" = {
      device = "/mnt/data/Secure";
      options = [ "bind" "rw" ];
    };

    "/home/${config.constellation.user.name}/Art" = {
      device = "/mnt/data/Art";
      options = [ "bind" "rw" ];
    };

  };

  swapDevices = [
    { device = "/dev/disk/by-partlabel/swap"; }
  ];

  hardware.opengl.enable = true;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidia.latest;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.forceFullCompositionPipeline = true;

  networking.hostName = "sol";
}
