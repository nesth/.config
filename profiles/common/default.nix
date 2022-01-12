{ config, pkgs, ... }:
{
  imports = [
    ../../modules/machine.nix
    ../../overlays
    ./git.nix
    ./zsh.nix
    ./nvim.nix
    ./zip.nix
  ];

  nixpkgs.config = import ./nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".text = pkgs.lib.generators.toPretty {} config.nixpkgs.config;

  home.packages = with pkgs; [
    coreutils
    fd
    file
    gnused
    htop
    less
    ripgrep
    rsync
    wget
    thefuck
    tfenv
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
  };
  xdg.enable = true;
}
