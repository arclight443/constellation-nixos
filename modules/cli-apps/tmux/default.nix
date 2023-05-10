{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.cli-apps.tmux;
  configFiles = lib.snowfall.fs.get-files ./config;

  plugins = with pkgs.tmuxPlugins; [
    continuum
    gruvbox
    tilish
    tmux-fzf
    vim-tmux-navigator
  ];
in
{
  options.constellation.cli-apps.tmux = with types; {
    enable = mkBoolOpt false "Whether or not to enable tmux.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      programs.tmux = {
        enable = true;
        terminal = "screen-256color-bce";
        clock24 = true;
        historyLimit = 2000;
        keyMode = "vi";
        newSession = true;
        extraConfig = builtins.concatStringsSep "\n"
          (builtins.map lib.strings.fileContents configFiles);

        inherit plugins;
      };
    };
  };
}
