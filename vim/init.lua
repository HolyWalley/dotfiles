local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn
local set = vim.opt
local map = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = ','

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

-- Use Esc to exit from terminal mode
map('t', '<Esc>', "<C-\\><C-n>", { noremap = true, silent = true })

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
  use 'tpope/vim-endwise'
  use 'easymotion/vim-easymotion'
  use 'junegunn/vim-easy-align'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  } -- statusline

  -- use { 'ibhagwan/fzf-lua',
  --   -- optional for icon support
  --   requires = { 'kyazdani42/nvim-web-devicons' }
  -- }

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use 'neovim/nvim-lspconfig'

  -- use 'mileszs/ack.vim'
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

  use 'akinsho/toggleterm.nvim'
  use 'slim-template/vim-slim'
  use 'editorconfig/editorconfig-vim'

  use 'evanleck/vim-svelte'

  use 'nvim-treesitter/nvim-treesitter'

  use 'hashivim/vim-terraform'

  use 'github/copilot.vim'
end)

-- Do not check for perl provider
vim.g['loaded_perl_provider'] = 0
vim.cmd('language en_US')
vim.g.gruvbox_flat_style = "dark"

vim.cmd[[colorscheme gruvbox-flat]]

set.exrc = true -- loads project specific vim config
set.number = true
set.relativenumber = true
set.wrap = false
set.cursorline = true

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
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-Tab>'] = function(fallback)
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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- LSP CONFIG
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

map('n', 'gh', '<C-W>]', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'solargraph', 'denols' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    -- flags = {
    --   -- This will be the default in neovim 0.7+
    --   debounce_text_changes = 150,
    -- },
    capabilities = capabilities
  }
end

require'lspconfig'.eslint.setup{
  packageManager = 'yarn',
    capabilities = capabilities
}

-- FZF
-- map('n', '<c-F>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
-- map('n', '<c-E>', "<cmd>lua require('fzf-lua').buffers()<CR>", { noremap = true, silent = true })

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = 'Show search buffers' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Copy to clipboard mapping
vim.keymap.set('v', '<Space>y', '"*y', {})

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

map('n', '<Leader>g', '<cmd>NvimTreeFindFileToggle<CR>', opts)

set.encoding='utf-8'

vim.opt.list = true

vim.opt.listchars = {
  trail = '~',
  tab = '>-',
}

require'toggleterm'.setup{
  size = 15,
  open_mapping = [[<Leader>t]],
}

-- More info about toggleterm internals here
-- https://github.com/akinsho/toggleterm.nvim/blob/93a7c59230f5dad60061318fefec35d431dec67f/lua/toggleterm.lua
function _G.run_spec()
  -- local current_file_path = vim.fn.expand('%')
  -- local current_file_path = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h'))
  local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")

  -- TODO: skip if not _spec or /specs/ file

  -- Beginning of the selection: line number, column number
  local b_line, b_col
  -- Window number from where we are calling the function (needed so we can get back to it automatically)
  local current_window = vim.api.nvim_get_current_win()

  b_line, b_col = unpack(vim.api.nvim_win_get_cursor(0))

  require'toggleterm'.exec('bundle exec rspec ~/' .. current_file_path, 1)

  -- Jump back with the cursor where we were at the begiining of the selection
  vim.api.nvim_set_current_win(current_window)
  vim.api.nvim_win_set_cursor(current_window, { b_line, b_col })
end
map('n', '<Leader>rs', ':lua run_spec()<CR>', {})

function _G.run_rubocop()
  -- local current_file_path = vim.fn.expand('%')
  -- local current_file_path = vim.fn.finddir('.git/..', vim.fn.expand('%:p:h'))
  local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")

  -- TODO: skip if not _spec or /specs/ file

  -- Beginning of the selection: line number, column number
  local b_line, b_col
  -- Window number from where we are calling the function (needed so we can get back to it automatically)
  local current_window = vim.api.nvim_get_current_win()

  b_line, b_col = unpack(vim.api.nvim_win_get_cursor(0))

  require'toggleterm'.exec('bundle exec rubocop ~/' .. current_file_path, 1)

  -- Jump back with the cursor where we were at the begiining of the selection
  vim.api.nvim_set_current_win(current_window)
  vim.api.nvim_win_set_cursor(current_window, { b_line, b_col })
end
map('n', '<Leader>rr', ':lua run_rubocop()<CR>', {})

map('n', '<leader>ti', ':!terraform init<CR>', opts)
map('n', '<leader>tv', ':!terraform validate<CR>', opts)
map('n', '<leader>tp', ':!terraform plan<CR>', opts)
map('n', '<leader>taa', ':!terraform apply -auto-approve<CR>', opts)

-- Load skeletons on file create based on file extension
for _, ext in pairs({ 'sh', 'rb' }) do
  autocmd( { "BufNewFile" }, {
    pattern = { "*." .. ext },
    command = [[0r ~/.config/nvim/skeletons/skeleton.]] .. ext,
  })
end

autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]]
})
