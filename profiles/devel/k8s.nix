{pkgs, ...}:
{
  imports = [
    
  ];

  home.packages = with pkgs; [
    kubectl
    kubectx
  ];
}
