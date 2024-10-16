local M = {}

function M.show_diagnostics()
  local current_win = vim.api.nvim_get_current_win()

  local trouble = require "trouble"

  trouble.toggle("diagnostics")
  vim.api.nvim_set_current_win(current_win)
end

function M.harpoon_menu()
  local harpoon = require "harpoon"

  harpoon.ui:toggle_quick_menu(harpoon:list())
end

return M
