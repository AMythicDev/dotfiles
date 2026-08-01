vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "options"
require("config.lazy")
require "bindings"

vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    require "lsp"
  end
})
