call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' " colorscheme

Plug 'itchyny/lightline.vim' " statusline
Plug 'shinchu/lightline-gruvbox.vim' " statusline theme

Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise' " automatically closes blocks of code
Plug 'tpope/vim-repeat' " Modifiest . command
Plug 'tpope/vim-fugitive' " Git support
Plug 'junegunn/gv.vim' " :GV and :GV! to view commit history
Plug 'tomtom/tcomment_vim' " Use gc comment blocks in visual mode
Plug 'jgdavey/vim-blockle' " ,b to toggle ruby blocks syntax
Plug 'othree/eregex.vim' " Perl/Ruby style regex notation
Plug 'othree/html5.vim' " Omnicomplete for html5
Plug 'easymotion/vim-easymotion' " Use \s to jump over the code
Plug 'junegunn/vim-easy-align' " Plugin to align code

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Ctrl-p but better
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim' " Search
Plug 'ap/vim-css-color' " Highlight colors
Plug 'editorconfig/editorconfig-vim' " Allows store code-style configs per project in .editorconfig file
Plug 'mg979/vim-visual-multi', { 'branch': 'master' } " Multicursor plugin

Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" Should definetelly take a look.
" Plug 'SirVer/ultisnips' " Snippers
" Plug 'honza/vim-snippets'

call plug#end()

if $TERM =~ '256'
  set termguicolors " true colors
  set t_Co=256
endif
set exrc " loads project spedific .nvimrc

"-----------------------
"""""""""""""""""""""""""
" KEYBINDINGS
"""""""""""""""""""""""""
let mapleader=","
inoremap jj <ESC>
map <Leader>r "hy:%S/<C-r>h//gc<left><left><left>
map <Leader>f *
map <Leader>rr :!ruby %<CR>
map <Leader>w :w<CR>
map <Leader>qa :wqa<CR>
map <Leader>[ :bprevious<CR>
map <Leader>] :bnext<CR>
map <Leader>p "+p<CR>
map <Leader>y "+y<CR>
map <Leader>D "_dd<CR>
map <Leader>d "_d<CR>
map <Leader>t :Ttoggle<CR>
map // :TComment<CR>
map <Leader>r8 :vertical resize 80<CR>
map <Leader>r12 :vertical resize 130<CR>
map <F5> :so $MYVIMRC<CR>
nnoremap <leader>. :Tags <CR>
nnoremap <Leader>fu :BTags<Cr>
nnoremap <C-e> :Buffers<CR>
" fix method jumping
nnoremap <buffer><silent> <C-]> :tag <C-R><C-W><CR>

" puts the caller
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

" Toggle NERDTreeToggle
nmap <Leader>g :NERDTreeToggle<CR>
" clear highlight
map <Leader><Leader>h :set hlsearch!<CR>

" regenerate CTAGS - https://github.com/universal-ctags/ctags
" map <Leader>ct :silent !ctags -R --exclude="*min.js"<CR>

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>

" EasyMotion
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

command! Q q " Bind :Q to :q
command! Qall qall
command! W w
" FZF
nnoremap <C-f> :FZF<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

map <Leader>t :call OpenTerminal()<CR>
map <Leader>jpp :call JSONPrettyPrint()<CR>

" Misc
set secure
set lazyredraw
set splitbelow
set splitright
set diffopt+=vertical
set shell=/bin/zsh
scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set clipboard=unnamed
filetype plugin indent on " Do filetype detection and load custom file plugins and indent files
set laststatus=2          " When you go into insert mode,
                          " the status line color changes.
                          " When you leave insert mode,
                          " the status line color changes back.

" Display options
syntax on
set pastetoggle=<F12>
set nocursorline
set number
set list!                       " Display unprintable characters
autocmd filetype html,xml,go set listchars=tab:\‚îÇ\ ,trail:-,extends:>,precedes:<,nbsp:+
colorscheme gruvbox
let g:gruvbox_contrast_dark = "medium" " soft, medium, hard
let g:gruvbox_contrast_light = "medium"
set background=dark
set t_ut= " fixes transparent BG on tmux

" Always edit file, even when swap file is found
set shortmess+=A
set hidden                         " Don't abandon buffers moved to the background
set wildmenu                       " Enhanced completion hints in command line
set backspace=eol,start,indent     " Allow backspacing over indent, eol, & start
set complete=.,w,b,u,U,t,i,d       " Do lots of scanning on tab completion
set completeopt-=preview           " Do not show preview window, just the menu
set directory=~/.config/nvim/swap  " Directory to use for the swap file
set diffopt=filler,iwhite          " In diff mode, ignore whitespace changes and align unchanged lines
set nowrap
set visualbell
set mouse=a

" Relative line numbers
set relativenumber
set rnu
" autocmd InsertLeave * :call NumberToggle()
" autocmd InsertEnter * :call NumberToggle()

" Indentation and tabbing
set autoindent smartindent
set smarttab                    " Make <tab> and <backspace> smarter
set expandtab
set shiftround
set incsearch
set shiftwidth=2
set softtabstop=2
set tabstop=2

" for html/rb files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" for js/css/scss/sass files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype css setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype scss setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype sass setlocal ts=4 sw=4 sts=0 expandtab

" viminfo: remember certain things when we exit
" (http://vimdoc.sourceforge.net/htmldoc/usr_21.html)
"   %    : saves and restores the buffer list
"   '100 : marks will be remembered for up to 30 previously edited files
"   /100 : save 100 lines from search history
"   h    : disable hlsearch on start
"   "500 : save up to 500 lines for each register
"   :100 : up to 100 lines of command-line history will be remembered
"   n... : where to save the viminfo files
set viminfo=%100,'100,/100,h,\"500,:100,n~/.config/nvim/viminfo

" Undo
set undolevels=1000                     " How many undos
set undoreload=10000                    " number of lines to save for undo
if has("persistent_undo")
  set undodir=~/.config/nvim/undo       " Allow undoes to persist even after a file is closed
  set undofile
endif

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch

" to_html settings
let html_number_lines = 1
let html_ignore_folding = 1
let html_use_css = 1
"let html_no_pre = 0
let use_xhtml = 1
let xml_use_xhtml = 1

" Show a vertical line/guard at column 80
" let &colorcolumn=join(range(81,999),",")
" highlight ColorColumn ctermbg=235 guibg=#2c2d27
" let &colorcolumn="80,".join(range(131,999),",")

" terminal colors
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

"""""""""""""""""""""""""
" Plugin's
"""""""""""""""""""""""""
" Ack.vimm
cnoreabbrev ag Ack -Q
cnoreabbrev aG Ack -Q
cnoreabbrev Ag Ack -Q
cnoreabbrev AG Ack -Q
cnoreabbrev F Ack -Q
cnoreabbrev f Ack -Q
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename'
      \ },
      \ }

" ignored files
set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/spec/vcr/*
set wildignore+=*/public/*
set wildignore+=*/coverage/*
set wildignore+=*.png,*.jpg,*.otf,*.woff,*.jpeg,*.orig

" EasyMotion
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

" delete trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" omnifuncs
set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

function! OpenTerminal()
  bot sp
  resize 10
  terminal
  set wfh
  set wfw
endfunc

function! JSONPrettyPrint()
  %!python -m json.tool
endfunction

if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
