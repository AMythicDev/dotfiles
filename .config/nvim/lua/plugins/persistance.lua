return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  -- NOTE: I only needed for neovide setup. With my new herdr setup, its now useless
  enabled = false,
  opts = {
    -- add any custom options here
  }
}
