{ pkgs, ... }:
with pkgs;
{
  home.packages = [
    unzip
    gzip
  ];
}
