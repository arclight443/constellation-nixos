{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.x11;

in
{
  options.constellation.desktop.addons.x11 = with types; {
    enable = mkBoolOpt false "Whether or not to enable common X11 settings.";
    gpu = mkOpt (enum [ "nvidia" "amd" ]) "amd" "GPU in-use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arandr
      xdotool
      xclip
      wmctrl
      inotify-tools
      glxinfo
    ];

    services.xserver = {
      enable = true;
      videoDrivers = if cfg.gpu == "nvidia" then [ "nvidia" ] else [ "amdgpu" ];
      serverFlagsSection = ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
        Option "BlankTime" "0"
      '';

      displayManager = {
        #lightdm.enable = true;
        #defaultSession = "none+awesome";

        autoLogin.enable = true;
        autoLogin.user = "jump";
        xserverArgs = [
          "-dpms"
        ];
      };

    };

    services.xserver.libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      mouse.accelSpeed = "0";
    };

    constellation.home.extraOptions = {
      home.pointerCursor = {
        name = "capitaine-cursors";
        package = pkgs.capitaine-cursors;
        gtk.enable = true;
      };
    };

  };



}
