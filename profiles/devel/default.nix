{pkgs, ...}:
{
  imports = [
    ./k8s.nix  
  ];

  home.packages = with pkgs; [
    yq-go
    google-cloud-sdk
    gnumake
  ];
}
