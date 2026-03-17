require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install { "bash", "lua", "markdown", "markdown_inline", "regex", "rust", "vim", "vimdoc" }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
