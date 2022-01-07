{ pkgs, ... }:
let
  unstable = import ./unstable.nix;
  home-manager = self: super: {
   home-manager = pkgs.callPackage ./home-manager.nix;
  };
in
{
  nixpkgs.overlays = [
    unstable
    home-manager
  ];
}
