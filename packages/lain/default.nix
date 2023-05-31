{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "lcpz";
  repo = "lain";
  rev = "88f5a8abd2649b348ffec433a24a263b37f122c0";
  sha256 = "MH/aiYfcO3lrcuNbnIu4QHqPq25LwzTprOhEJUJBJ7I=";
  name = "lain";
}
