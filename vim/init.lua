local Plug = vim.fn['plug#']
local cmd = vim.cmd

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'morhetz/gruvbox' -- colorscheme

Plug 'itchyny/lightline.vim' -- statusline
Plug 'shinchu/lightline-gruvbox.vim' -- statusline theme

Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise' -- automatically closes blocks of code
Plug 'tpope/vim-repeat' -- Modifiest . command
Plug 'tpope/vim-fugitive' -- Git support
Plug 'junegunn/gv.vim' -- :GV and :GV! to view commit history
Plug 'tomtom/tcomment_vim' -- Use gc comment blocks in visual mode
Plug 'jgdavey/vim-blockle' -- ,b to toggle ruby blocks syntax
Plug 'othree/eregex.vim' -- Perl/Ruby style regex notation
Plug 'othree/html5.vim' -- Omnicomplete for html5
Plug 'easymotion/vim-easymotion' -- Use \s to jump over the code
Plug 'junegunn/vim-easy-align' -- Plugin to align code

Plug('junegunn/fzf', { dir = '~/.fzf', ['do'] = vim.fn['fzf#install'] }) -- Ctrl-p but better
Plug 'junegunn/fzf.vim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'mileszs/ack.vim' -- Search
Plug 'ap/vim-css-color' -- Highlight colors
Plug 'editorconfig/editorconfig-vim' -- Allows store code-style configs per project in .editorconfig file
Plug('mg979/vim-visual-multi', { branch = 'master' }) -- Multicursor plugin

Plug('preservim/nerdtree', { on = 'NERDTreeToggle' })

Plug 'kassio/neoterm'
Plug 'jakelinnzy/autocmd-lua'

Plug 'neovim/nvim-lspconfig'

-- Should definetelly take a look.
-- Plug 'SirVer/ultisnips' " Snippers
-- Plug 'honza/vim-snippets'

vim.call('plug#end')

if string.find(vim.env.TERM, '256') ~= nil then
  vim.opt.termguicolors = true -- true colors
end
vim.opt.exrc = true -- loads project spedific .nvimrc

-- KEYBINDINGS --
vim.g.mapleader = ','

-- FZF
vim.api.nvim_set_keymap('n', '<C-f>', ':FZF<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-e>', ':Buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '//', ':TComment<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>wtf', 'oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>', {})
vim.api.nvim_set_keymap('n', '<Leader>g', ':NERDTreeToggle<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader><Leader>h', ':set hlsearch!<cr>', {})

vim.api.nvim_set_keymap('n', '<Leader>e', ':e <C-R>=escape(expand("%:p:h")," ") . "/"<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>s', ':split <C-R>=escape(expand("%:p:h")," ") . "/"<cr>', {})
vim.api.nvim_set_keymap('n', '<Leader>v', ':vnew <C-R>=escape(expand("%:p:h")," ") . "/"<cr>', {})

-- EasyMotion
vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-s2)', {})
vim.api.nvim_set_keymap('n', 't', '<Plug>(easymotion-t2)', {})
vim.api.nvim_set_keymap('n', '<Leader>l', '<Plug>(easymotion-lineforward)', {})
vim.api.nvim_set_keymap('n', '<Leader>j', '<Plug>(easymotion-j)', {})
vim.api.nvim_set_keymap('n', '<Leader>k', '<Plug>(easymotion-k)', {})
vim.api.nvim_set_keymap('n', '<Leader>h', '<Plug>(easymotion-linebackward)', {})

-- MISC --
vim.opt.secure = true
vim.opt.lazyredraw = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.diffopt = vim.opt.diffopt + 'vertical'
vim.opt.shell = '/bin/zsh'
vim.opt.encoding = 'utf-8'
vim.opt.clipboard = 'unnamed'

cmd 'filetype plugin indent on'

-- Display options
vim.opt.pastetoggle = '<F12>'
vim.opt.number = true
vim.opt.list = true
cmd 'colorscheme gruvbox'

-- Always edit file, even when swap file is found
vim.opt.shortmess = vim.opt.shortmess + 'A'
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.directory = '~/.config/nvim/swap'
vim.opt.visualbell = true
vim.opt.mouse = 'a'

vim.opt.relativenumber = true
vim.opt.rnu = true

-- Indentation and tabbing
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.incsearch = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- for html/rb files, 2 spaces
cmd 'autocmd Filetype html setlocal ts=2 sw=2 expandtab'
cmd 'autocmd Filetype ruby setlocal ts=2 sw=2 expandtab'

-- for js/css/scss/sass files, 4 spaces
cmd 'autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab'
cmd 'autocmd Filetype css setlocal ts=4 sw=4 sts=0 expandtab'
cmd 'autocmd Filetype scss setlocal ts=4 sw=4 sts=0 expandtab'
cmd 'autocmd Filetype sass setlocal ts=4 sw=4 sts=0 expandtab'

-- Undo
vim.opt.undolevels=1000                 -- How many undos
vim.opt.undoreload=10000                    -- number of lines to save for undo
if vim.fn.has("persistent_undo") == 1 then
  vim.opt.undodir = '~/.config/nvim/undo'       -- Allow undoes to persist even after a file is closed
  vim.opt.undofile = true
end

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showmatch = true

-- Plugins --
-- Ack.vim
cmd 'cnoreabbrev ag Ack -Q'
cmd 'cnoreabbrev aG Ack -Q'
cmd 'cnoreabbrev Ag Ack -Q'
cmd 'cnoreabbrev AG Ack -Q'
cmd 'cnoreabbrev F Ack -Q'
cmd 'cnoreabbrev f Ack -Q'

if vim.fn.executable('ag') == 1 then
  vim.api.nvim_set_var('ackprg', 'ag --vimgrep --smart-case')
end

vim.api.nvim_set_var('lightline', {
  colorscheme = 'gruvbox',
  active = {
    left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' } }
  },
  component_function = {
    gitbranch = 'fugitive#head',
    filename = 'LightlineFilename'
  }
})

vim.opt.wildignore = vim.opt.wildignore + 'tags'
vim.opt.wildignore = vim.opt.wildignore + '*/tmp/*'
vim.opt.wildignore = vim.opt.wildignore + '*/spec/vcr/*'
vim.opt.wildignore = vim.opt.wildignore + '*/public/*'
vim.opt.wildignore = vim.opt.wildignore + '*/coverage/*'
vim.opt.wildignore = vim.opt.wildignore + '*.png,*.jpg,*.otf,*.woff,*.jpeg,*.orig'

-- EasyMotion
-- Use uppercase target labels and type as a lower case
vim.api.nvim_set_var('EasyMotion_use_upper', 1)
-- type `l` and match `l`&`L`
vim.api.nvim_set_var('EasyMotion_smartcase ', 1)
-- Smartsign (type `3` and match `3`&`#`)
vim.api.nvim_set_var('EasyMotion_use_smartsign_us ', 1)

-- require('autocmd-lua').augroup {
--   group = 'test_group',
--   autocmds = {
--     { event = 'FileType', pattern = 'lua', cmd = function() vim.opt.sw = 2 end },
--     -- the keys above are optional
--     { 'BufWritePre', '*', '%s\s\+$//e'},
--   },
-- }

-- delete trailing spaces
-- cmd 'autocmd BufWritePre * %s\s\+$//e'
