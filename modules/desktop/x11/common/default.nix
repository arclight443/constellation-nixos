{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.x11.common;

in
{
  options.constellation.desktop.x11.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common X11 settings.";
    gpu = mkOpt (enum [ "nvidia" "amd" ]) "amd" "GPU in-use.";
    uiScaling = mkOpt (enum [ "normal" "enlarged" ]) "normal" "UI scaling to use.";

  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arandr
      xdotool
      xclip
      wmctrl
      inotify-tools
      glxinfo
      snixembed
      xcolor
    ];

    services = {
      getty.autologinUser = "${config.constellation.user.name}";
      xserver = {
        enable = true;
        videoDrivers = if cfg.gpu == "nvidia" then [ "nvidia" ] else [ "amdgpu" ];

        serverFlagsSection = ''
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
          Option "BlankTime" "0"
        '';

        #displayManager = {

        #  autoLogin = {
        #    enable = true;
        #    user = "${config.constellation.user.name}";
        #  };

        #  lightdm = {
        #    enable = true;
        #    greeters.gtk = {
        #      enable = true;
        #      theme = {
        #        name = "gruvbox-dark";
        #        package = pkgs.gruvbox-dark-gtk;
        #      };
        #      iconTheme = {
        #        name = "oomox-gruvbox-dark";
        #        package = pkgs.gruvbox-dark-icons-gtk;
        #      };
        #      cursorTheme = {
        #        name = "capitaine-cursors";
        #        package = pkgs.capitaine-cursors;
        #      };
        #    };
        #  };

        #  defaultSession = "none+awesome";

        #  xserverArgs = [
        #    "-dpms"
        #  ];

        #};

        libinput = {
          enable = true;
          mouse.accelProfile = "flat";
          mouse.accelSpeed = "0";
          touchpad.naturalScrolling = true;
        };
      };

      unclutter = {
        enable = true;
        timeout = 60;
        keystroke = true;
      };
    };

    constellation = {
      desktop.utils = {
        fcitx5 = enabled;
        kitty = enabled;
        gtk = enabled;
        qt = enabled;
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
