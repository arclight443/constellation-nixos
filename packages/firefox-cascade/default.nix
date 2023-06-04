{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "arclight443";
  repo = "cascade";
  rev = "3e3fc24e4fb357cc22922a13bf52aabd50c926bc";
  sha256 = "3eAVf+bNwAyLFDMCI7TVU6BPI5T9fvCSFrYjZtfgSp4=";
  name = "firefox-cascade";
}
