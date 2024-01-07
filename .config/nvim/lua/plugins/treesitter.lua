require"nvim-treesitter.configs".setup {
  ensure_installed = { "bash", "lua", "markdown", "markdown_inline", "regex", "rust", "vim", "vimdoc" },
  auto_install = false,

  highlight = {
    enable = true
  },

  indent = {
    enable = true
  },
}
