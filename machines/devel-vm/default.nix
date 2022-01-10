{ pkgs, ...}:
{
  imports = [
    ../../profiles/common
    ../../services/nixos-vscode-ssh-fix.nix
  ];

  machine = ./.;
  services = {
   nixos-vscode-ssh-fix.enable = true;
  };
}
