{ config, pkgs, ... }:
{
  imports = [
    ../../modules/machine.nix
    ../../overlays
    ./git.nix
    ./zsh.nix
    ./nvim.nix
  ];

  nixpkgs.config = import ./nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".text = pkgs.lib.generators.toPretty {} config.nixpkgs.config;

  home.packages = with pkgs; [
    coreutils
    fd
    gnused
    htop
    less
    nixops
    ranger
    ripgrep
    rsync
    wget
    unstable.youtube-dl
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
  };
  xdg.enable = true;
}
