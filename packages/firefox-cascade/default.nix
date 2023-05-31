{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "karamanliev";
  repo = "cascade";
  rev = "1f81d4c031f44e5a6fda62e75c75fd123f657ee9";
  sha256 = "18jvzwnmz7wyzmpg2m1r3ycs1y6da2257xj0xdkqdxif4xxy6ns5";
  name = "firefox-cascade";
}
