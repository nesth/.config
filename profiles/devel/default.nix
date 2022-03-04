{pkgs, ...}:
{
  imports = [
    ./k8s.nix  
  ];

  home.packages = with pkgs; [
    go-outline
    google-cloud-sdk
    gopls
    gnumake
    kubernetes-helm
    yq-go
  ];
}
