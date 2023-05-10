{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.tools.misc;
in
{
  options.constellation.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    constellation.home.configFile."wgetrc".text = "";
    programs.ssh.askPassword = "";

    environment.systemPackages = with pkgs; [
      fzf
      killall
      unzip
      file
      jq
      clac
      wget
    ];
  };
}
