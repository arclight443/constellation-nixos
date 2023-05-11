{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "arclight443";
  repo = "cascade";
  rev = "c4403df6c3ca7ac720cbad1d56468ec58e3ceb4f";
  sha256 = "sha256-NeWMziQyL7Aylx6kiTmj73TTEsmzPkAalOqR6X3ZzB8=";
  name = "firefox-cascade";
}
