local function mode()
  return vim.fn.mode(0)
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename', },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.api.nvim_create_autocmd({ "LspAttach" }, {
  callback = function()
    local lualine = require "lualine"

    local config = lualine.get_config()

    config.sections.lualine_c[2] = function() return require "lsp-progress".progress() end
    config.sections.lualine_c[3] = function() return require "lspsaga.symbol.winbar".get_bar() end

    lualine.setup(config)
  end
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("Ad/LspProgress", { clear = true }),
  pattern = "LspProgressStatusUpdated",
  callback = function() require("lualine").refresh() end,
})
