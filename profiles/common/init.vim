"colorscheme aaa
filetype plugin indent on
command! -bar -nargs=0 Sudow   :silent exe "write !sudo tee % >/dev/null"|silent edit!
command! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool
"syntax match nonascii "[^\x00-\x7F]"
syntax on

filetype plugin indent on
set modeline
set number
set mouse=a
"set clipboard=unnamed

set encoding=utf-8
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Filetype indentation
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

" Setup Crosshairs {{{2
:hi CursorLine   cterm=none ctermbg=235
:hi CursorColumn cterm=NONE ctermbg=235
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter,BufEnter,ColorScheme * setlocal cursorline cursorcolumn
    au VimEnter,WinEnter,BufWinEnter,BufEnter,ColorScheme * :hi CursorLine   cterm=none ctermbg=235
    au VimEnter,WinEnter,BufWinEnter,BufEnter,ColorScheme * :hi CursorColumn cterm=NONE ctermbg=235
    au WinLeave * setlocal nocursorline nocursorcolumn
augroup END

let g:colors_name = "aaa"

" Backup all files
set backup

function! BackupDir()
   if has('win32') || has('win64')
      let l:backupdir=$VIM.'/backup/'.
               \substitute(expand('%:p:h'), '\:', '~', '')
   else
      let l:backupdir=$HOME.'/.vim/backup/'.
               \substitute(expand('%:p:h'), '^'.$HOME, '~', '')
   endif

   if !isdirectory(l:backupdir)
      call mkdir(l:backupdir, 'p', 0700)
   endif

   let &backupdir=l:backupdir
   let &backupext=strftime('~%Y-%m-%d_%H-%M-%S~')
endfunction

autocmd! bufwritepre * call BackupDir()

" Airline
let g:airline#extensions#tabline#enabled = 1

function! s:tagbar_intergration()
endfunction



if has("gui_running")
"    highlight Normal guifg=White   guibg=Black
    highlight Cursor guifg=Black   guibg=Yellow
    highlight Keyword guifg=#FF6600
    highlight Define guifg=#FF6600
    highlight Comment guifg=#9933CC
    highlight Type guifg=White gui=NONE
    highlight rubySymbol guifg=#339999 gui=NONE
    highlight Identifier guifg=White gui=NONE
    highlight rubyStringDelimiter guifg=#66FF00
    highlight rubyInterpolation guifg=White
    highlight rubyPseudoVariable guifg=#339999
    highlight Constant guifg=#FFEE98
    highlight Function guifg=#FFCC00 gui=NONE
    highlight Include guifg=#FFCC00 gui=NONE
    highlight Statement guifg=#FF6600 gui=NONE
    highlight String guifg=#66FF00
    highlight Search guibg=White
    highlight CursorLine guibg=#323300
else
    set t_Co=256
"    highlight Normal ctermfg=White ctermbg=Black
    highlight Cursor ctermfg=Black ctermbg=Yellow
    highlight Keyword ctermfg=202
    highlight Define ctermfg=202
    highlight Comment ctermfg=98
    highlight Type ctermfg=White
    highlight rubySymbol ctermfg=66
    highlight Identifier ctermfg=White
    highlight rubyStringDelimiter ctermfg=82
    highlight rubyInterpolation ctermfg=White
    highlight rubyPseudoVariable ctermfg=66
    highlight Constant ctermfg=228
    highlight Function ctermfg=220
    highlight Include ctermfg=220
    highlight Statement ctermfg=202
    highlight String ctermfg=82
    highlight Search ctermbg=White
    highlight CursorLine cterm=NONE ctermbg=235
endif

