{ pkgs, ...}:
{
  imports = [
    ../../profiles/common
    ../../profiles/devel
    ../../services/nixos-vscode-ssh-fix.nix
  ];

  machine = ./.;
  services = {
   nixos-vscode-ssh-fix.enable = true;
  };
}
