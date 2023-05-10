{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.cli-apps.ncmpcpp;
in
{
  options.constellation.cli-apps.ncmpcpp = with types; {
    enable = mkBoolOpt false "Whether or not to enable ncmpcpp.";
  };

  config = mkIf cfg.enable {
    constellation.home.configFile."ncmpcpp/" = {
      source = ./config;
      recursive = true;
    };

    constellation.home.extraOptions = {

      home.packages = with pkgs; [
        (buildEnv
          {
            name = "scripts";
            paths = [ ./scripts ];
          }
        )
        flac
        mpc-cli
        ffmpeg
      ];

      services = {
        mpd = {
          enable = true;
          musicDirectory = "~/Music";
          playlistDirectory = "/home/jump/Music/Playlist";
          extraConfig = ''
            audio_output {
               type  "pipewire"
               name  "Primary Audio Stream"
             }

             audio_output {
               type    "fifo"
               name    "Visualizer"
               path    "/tmp/mpd.fifo"
               format  "44100:16:1"
             }
          '';
        };
      };

      programs.ncmpcpp = {
        enable = true;
        mpdMusicDir = "~Music/";

        bindings = [
          { key = "j"; command = "scroll_down"; }
          { key = "k"; command = "scroll_up"; }
          { key = "J"; command = [ "select_item" "scroll_down" ]; }
          { key = "K"; command = [ "select_item" "scroll_up" ]; }
        ];

        settings = {
          allow_for_physical_item_deletion = "yes";
          execute_on_song_change = "ncmpcpp_cover_art";
        };

      };
    };
  };
}
