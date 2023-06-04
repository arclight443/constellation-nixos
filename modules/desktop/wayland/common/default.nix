{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.wayland.common;

in
{
  options.constellation.desktop.wayland.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common wayland settings.";
    gpu = mkOpt (enum [ "nvidia" "amd" ]) "amd" "GPU in-use.";
    uiScaling = mkOpt (enum [ "normal" "enlarged" ]) "normal" "UI scaling to use.";

  };

  config = mkIf cfg.enable {

    services = {
      getty.autologinUser = "${config.constellation.user.name}";
      xserver = {
        enable = true;
        videoDrivers = if cfg.gpu == "nvidia" then [ "nvidia" ] else [ "amdgpu" ];
        displayManager.lightdm.enable = false;

      };

    };

    constellation = {
      desktop.utils = {
        fcitx5 = enabled;
        kitty = enabled;
        gtk = {
          enable = true;
          uiScaling = "normal";
        };
        qt = {
          enable = true;
          uiScaling = "normal";
        };
      };

      desktop.wayland = {
        swww = enabled;
        waybar = enabled;
        misc = enabled;
      };

      home.extraOptions = {
        home.pointerCursor = {
          name = "capitaine-cursors";
          package = pkgs.capitaine-cursors;
          gtk.enable = true;
        };
      };

    };

  };


}
