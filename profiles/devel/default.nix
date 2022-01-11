{pkgs, ...}:
{
  imports = [
    
  ];

  home.packages = with pkgs; [
    yq-go
    google-cloud-sdk
    gnumake
  ];
}
