local function set_obsidian_bindings()
  vim.keymap.set("n", "<localleader>o", ":Obsidian open<CR>", { silent = true })
  vim.keymap.set("n", "<localleader>n", ":Obsidian unique_note", { silent = true })
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",             -- use latest release, remove to use latest commit
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    picker = {
      name = "snacks.picker",
    },
    frontmatter = { enabled = false },
    completion = {
      lsp = true,
    },
    unique_note = {
      format = "YYYY-MM-DD HHmm",
      template = "Note.md",
    },
    templates = {
      folder = "Templates/"
    },
    workspaces = {
      {
        name = "The Brain",
        path = "~/The Brain/",
      },
    },
    callbacks = {
      enter_note = set_obsidian_bindings
    },
  },
}
