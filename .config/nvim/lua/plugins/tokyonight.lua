return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true, -- Enable global transparency
    on_highlights = function(hl, c)
      --   -- Restore background for bufferline groups
      --   -- These common groups ensure the bar remains opaque
      --   hl.BufferLineFill = { bg = c.bg_dark }
      --   hl.BufferLineBackground = { bg = c.bg_dark }
      --   hl.BufferLineSeparator = { fg = c.bg_dark, bg = c.bg_dark }
      --
      --   -- Optional: If you want active/inactive tabs to have specific backgrounds
      --   hl.BufferLineBufferSelected = { bg = c.bg_statusline, bold = true }
      --   hl.BufferLineBufferVisible = { bg = c.bg_dark }
      hl.FlashLabel = { fg = "white", bold = true }
      hl.LspInlayHint = { bg = "none", fg = "#545c7e" }
    end,
    styles = {
      sidebars = "transparent", -- e.g., nvim-tree, vista
      floats = "transparent",   -- e.g., telescope, cmp windows
    },
  },
  config = function(_, opts)
    require "tokyonight".setup(opts)
    vim.cmd [[colorscheme tokyonight-night]]
  end
}
