{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "QnetITQ";
  repo = "WaveFox";
  rev = "fb18276509d592a3c99d52dde5e99087ef342afe";
  sha256 = "sha256-kgXZJvuEGHCWNkAJT5Dj4l8OoAJ2aBnCAIHhUWZysSo= ";
  name = "firefox-wavefox";
}
