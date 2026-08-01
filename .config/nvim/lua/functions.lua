local M = {}

function M.show_diagnostics()
  local current_win = vim.api.nvim_get_current_win()

  local trouble = require "trouble"

  trouble.toggle("diagnostics")
  vim.api.nvim_set_current_win(current_win)
end

return M
