{ pkgs, ... }:
let
  unstable = import ./unstable.nix;
  home-manager = self: super: {
    home-manager = pkgs.callPackage ./home-manager.nix;
  };
  packages = import ./packages.nix;
in
{
  nixpkgs.overlays = [
    unstable
    home-manager
    packages
  ];
}
