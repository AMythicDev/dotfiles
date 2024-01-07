require("tokyonight").setup({
  style = "night",

  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = c.blue,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.red,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.WinSeparator = {
      fg = c.fg_float,
    }
    hl.CursorLineNr = {
      fg = c.cyan,
    }
  end,
})
