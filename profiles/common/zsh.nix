{ config, lib, pkgs, ... }:

let
  shellAliases = {
      k = "kubectl";
      kns = "kubens";
      kctx = "kubectx";
      l = "exa";
      ls = "exa";
      ll = "exa -l --git";
      q = "exit";
      vi = "vim";
      t = "terraform";
      aa = "kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2; kubectl -n argocd port-forward $(kubectl -n argocd get pods -l app.kubernetes.io/name=argocd-server -o name) 8090:8080";
      cc = "kubectl port-forward -n chaos-testing svc/chaos-dashboard 2333:2333";
      dr = "TERM=xterm darwin-rebuild switch";
      flip = "echo '(╯°□°)╯︵ ┻━┻'";
      #sway = "exec dbus-launch --sh-syntax --exit-with-session sway";
  };

  promptInit = ''
  '';

  zshInitExtra = builtins.readFile ./files/zshrc;

in
{
    home.packages = with pkgs; [
        exa
        direnv
        kubectl
        kubectx
        thefuck
        sqlite
        powerline-go
    ];

    home.sessionPath = ["~/bin"];

    programs.zsh = {
      enable = true;
      inherit shellAliases;
      initExtra = zshInitExtra;
      autocd = true;
      history = {
       size = 10000000;
       save = 10000000;
       extended = true;
      };
      plugins = [
       {
          name = "zsh-histdb";
          src = pkgs.fetchFromGitHub {
            owner = "larkery";
            repo = "zsh-histdb";
            rev = "master";
            sha256 = "sha256-gqsd+tW2d/Dyo1IhjSxW6SKsT5dDNvOM1EglzK4UAAM=";
          };
       }
       {
          name = "zsh-kitty";
          src = pkgs.fetchFromGitHub {
            owner = "redxtech";
            repo = "zsh-kitty";
            rev = "master";
            sha256 = "1197vx1ndrv6n1jwg0xp8fv0d8j5idaa4c4f4sp5p0fp2gl5xmj9";
          };
       }
       {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "master";
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
       }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [
          "gcloud"
          "gitfast"
          "safe-paste"
          "vi-mode"
        ];
      };
    };

  programs.fzf = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";

  };
}
