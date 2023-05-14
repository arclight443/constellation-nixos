{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "arclight443";
  repo = "cascade";
  rev = "7d788666936ee06acbb69adf8e9a33e6ce0edc25";
  sha256 = "macR4sHfQGiTEkMbRMuCqh6nsTnWRe8b511eY9ytBt4=";
  name = "firefox-cascade";
}
