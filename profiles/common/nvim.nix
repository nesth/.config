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
      withNodeJs = true;
      coc = {
        enable = true;
        package = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "coc.nvim";
          version = "2022-05-21";
          src = pkgs.fetchFromGitHub {
            owner = "neoclide";
            repo = "coc.nvim";
            rev = "791c9f673b882768486450e73d8bda10e391401d";
            sha256 = "sha256-MobgwhFQ1Ld7pFknsurSFAsN5v+vGbEFojTAYD/kI9c=";
          };
          meta.homepage = "https://github.com/neoclide/coc.nvim/";
        };
        settings = {
          client.snippetSupport = true;

          suggest = {
            enablePreview = true;
            noselect = true;
            enablePreselect = true;
          };

          languageserver = {
            nix = {
              command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
              filetypes = ["nix"];
              rootPatterns = ["flake.lock" ".git"];
            };

            terraform = {
              command = "${pkgs.terraform-ls}/bin/terraform-ls";
              args = ["serve" "--tf-log-file" "/tmp/tls-vim.log"];
              filetypes = ["terraform" "tf"];
              initializationOptions = {};
            };
          };
        };
        pluginConfig = ''
          " CoC Extensions
          let g:coc_global_extensions=[
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-sh',
            \ 'coc-yaml',
            \ ]

          set updatetime=300
          set shortmess+=c

          " Use tab for trigger completion with characters ahead and navigate.
          inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
          inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

          function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
          endfunction

          " Remap keys for gotos
          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gy <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)

          " Formatting
          vmap <C-F> <Plug>(coc-format-selected)
          xmap <C-F> :call CocAction('format')<CR>
          nmap <C-F> :call CocAction('format')<CR>

          " Hover and rename
          nmap <silent> <F6> <Plug>(coc-rename)
          nnoremap <silent> K :call CocAction('doHover')<CR>

          " Go to symbol in (document|project)
          nmap <silent> S :CocList symbols<CR>

        '';
      };
      extraPackages = with pkgs; [
        ripgrep
        yarn
        lua
      ];
      plugins = with pkgs.vimPlugins; [
        ctrlp-vim
        fugitive
        plenary-nvim
        telescope-nvim
        undotree
        vim-addon-nix
        vim-airline
        vim-airline-themes
        vim-nix
        vim-signify
        vim-terraform
      ];
      extraConfig = builtins.readFile ./files/init.vim;
    };
}
