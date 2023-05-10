{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.hardware.nvidia;
in
{
  options.constellation.hardware.nvidia = with types; {
    enable = mkBoolOpt false "Whether or not to enable support for Nvidia proprietary driver.";
  };

  config = mkIf cfg.enable {
    hardware.opengl.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidia.stable;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.forceFullCompositionPipeline = true;
  };
}
