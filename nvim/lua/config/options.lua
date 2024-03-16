-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keybindings to run tests based on file type
vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>lua RunTests(false)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>lua RunTests(true)<CR>", { noremap = true, silent = true })

return {}
