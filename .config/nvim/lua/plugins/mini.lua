return {
  'echasnovski/mini.nvim',
  version = '*',
  event = "VeryLazy",
  config = function()
    require "mini.ai".setup()

    require "mini.pairs".setup()

    require "mini.surround".setup({
      mappings = {
        add = 'Za',        -- Add surrounding in Normal and Visual modes
        delete = 'Zd',     -- Delete surrounding
        find = 'Zf',       -- Find surrounding (to the right)
        find_left = 'ZF',  -- Find surrounding (to the left)
        highlight = 'Zh',  -- Highlight surrounding
        replace = 'Zr',    -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      }
    })

    require "mini.comment".setup({
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = '<leader>/',

        -- Toggle comment on current line
        comment_line = '<leader>/',

        -- Toggle comment on visual selection
        comment_visual = '<leader>/',

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = '<leader>/',
      },
    })

    require "mini.bracketed".setup({});
  end,
}
