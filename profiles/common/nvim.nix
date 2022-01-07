{ config, pkgs, lib, ...}:

let
  galaxyline = pkgs.vimUtils.buildVimPlugin {
    name = "galaxyline.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "galaxyline.nvim";
      rev = "main";
      sha256 = "1390lqsqdcj1q89zn6y5qrm1id7p8fnpy07vlz6mm4cki47211mb";
    };
  };
in {
    home.sessionVariables = {
      EDITOR = "vim";
    };

    programs.vim = {
        enable = false;
        plugins = [
          pkgs.vimPlugins.vim-sensible
          pkgs.vimPlugins.vim-airline
          pkgs.vimPlugins.nerdtree
          pkgs.vimPlugins.vim-terraform
          pkgs.vimPlugins.vim-terraform-completion

        ];
        extraConfig = builtins.readFile ./vimrc;
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraPackages = with pkgs; [
        nodejs
        yarn
        lua
      ];
      plugins = with pkgs.vimPlugins; [
        coc-nvim
        coc-prettier
        ctrlp-vim
        fugitive
        undotree
        vim-addon-nix
        vim-airline
        vim-airline-themes
        vim-signify
      ];
      extraConfig = builtins.readFile ./init.vim;
    };

    xdg.configFile."nvim/coc-settings.json".text = builtins.readFile ./coc-settings.json;
}
