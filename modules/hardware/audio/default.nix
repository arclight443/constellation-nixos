{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.hardware.audio;
in
{
  options.constellation.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio support.";
    alsa-monitor = mkOpt attrs { } "Alsa configuration.";
    nodes = mkOpt (listOf attrs) [ ]
      "Audio nodes to pass to Pipewire as `context.objects`.";
    modules = mkOpt (listOf attrs) [ ]
      "Audio modules to pass to Pipewire as `context.modules`.";
    extra-packages = mkOpt (listOf package) [
      pkgs.qjackctl
      pkgs.easyeffects
    ] "Additional packages to install.";
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;

      wireplumber.enable = true;

    };

    hardware.pulseaudio.enable = mkForce false;

    environment.systemPackages = with pkgs; [
      alsa-utils
      pulsemixer
      pavucontrol
    ] ++ cfg.extra-packages;

    constellation.user.extraGroups = [ "audio" ];

  };
}
