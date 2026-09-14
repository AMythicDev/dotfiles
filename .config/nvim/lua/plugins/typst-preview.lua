return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = '1.*',
  build = function()
    require("typst-preview").update()
  end,
  opts = {
    -- Follow your cursor focus in the preview window
    follow_cursor = true,
    dependencies_bin = { tinymist = 'tinymist', websocat = nil },
  },
  config = function(_, opts)
    require "typst-preview".setup(opts)
    vim.keymap.set("n", "<localleader>p", function() vim.cmd "TypstPreviewToggle" end, {
      desc = "Toggle typst preview",
      silent = true
    })
  end
}
