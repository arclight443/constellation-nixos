{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "arclight443";
  repo = "cascade";
  rev = "f49e58c05879df0c196edf850e5529faf7b80512";
  sha256 = "jnVwksBNQmvnOqfYJZ1tTOfVd4ZANU3YgeTI1UHurTw=";
  name = "firefox-cascade";
}
