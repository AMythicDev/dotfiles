vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.lazy")

vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    require "lsp"
  end
})
