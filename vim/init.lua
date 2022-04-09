local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn
local set = vim.opt
local map = vim.api.nvim_set_keymap

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function()
  local use = use

  use 'eddyekofo94/gruvbox-flat.nvim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'easymotion/vim-easymotion'
  use 'junegunn/vim-easy-align'
  use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  } -- statusline

  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'neovim/nvim-lspconfig'

  use 'mileszs/ack.vim'
  use { 'mg979/vim-visual-multi', branch = 'master' } -- Multicursor plugin

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
end)

-- Do not check for perl provider
vim.g['loaded_perl_provider'] = 0
vim.cmd('language en_US')
vim.g.gruvbox_flat_style = "hard"

vim.cmd[[colorscheme gruvbox-flat]]

set.exrc = true -- loads project specific vim config
set.number = true
set.relativenumber = true

-- Indentation and tabbing
set.autoindent=true
set.smarttab=true
set.expandtab=true
set.shiftround=true
set.incsearch=true
set.shiftwidth=2
set.softtabstop=2
set.tabstop=2

-- Persistent undo
set.undolevels=1000                     -- How many undos
set.undoreload=10000                    -- number of lines to save for undo
set.undodir='/Users/yakaukrasnou/.config/nvim/undo'       -- Allow undoes to persist even after a file is closed
set.undofile=true

-- Search settings
set.ignorecase=true
set.smartcase=true
set.hlsearch=true
set.incsearch=true
set.showmatch=true

set.mouse='a'

-- KEYBINDINGS --
vim.g.mapleader = ','

-- Plugins --
-- LuaLine - fancy status line
require('lualine').setup {
  options = {
    theme = 'gruvbox-flat'
  }
}

-- nvim-cmp
set.completeopt=menu,menuone,noselect

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- LSP CONFIG
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'solargraph', 'denols', 'dockerls', 'yamlls', 'tailwindcss' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end

-- FZF
map('n', '<c-F>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
map('n', '<c-E>', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })

-- Ack.vim
vim.cmd 'cnoreabbrev ag Ack! -Q'
vim.cmd 'cnoreabbrev aG Ack! -Q'
vim.cmd 'cnoreabbrev Ag Ack! -Q'
vim.cmd 'cnoreabbrev AG Ack! -Q'
vim.cmd 'cnoreabbrev F Ack! -Q'
vim.cmd 'cnoreabbrev f Ack! -Q'

if fn.executable('ag') == 1 then
  vim.api.nvim_set_var('ackprg', 'ag --vimgrep --smart-case')
end

-- Easymotion
-- Use uppercase target labels and type as a lower case
vim.api.nvim_set_var('EasyMotion_use_upper', 1)
-- type `l` and match `l`&`L`
vim.api.nvim_set_var('EasyMotion_smartcase ', 1)
-- Smartsign (type `3` and match `3`&`#`)
vim.api.nvim_set_var('EasyMotion_use_smartsign_us ', 1)

-- EasyMotion
map('n', 's', '<Plug>(easymotion-s2)', {})
map('n', '<Leader>l', '<Plug>(easymotion-lineforward)', {})
map('n', '<Leader>j', '<Plug>(easymotion-j)', {})
map('n', '<Leader>k', '<Plug>(easymotion-k)', {})
map('n', '<Leader>h', '<Plug>(easymotion-linebackward)', {})

-- NERDTree
vim.g.nosplitright = false
require'nvim-tree'.setup {}

map('n', '<Leader>g', '<cmd>NvimTreeToggle<CR>', opts)
