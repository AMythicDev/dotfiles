require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install { "bash", "lua", "markdown", "markdown_inline", "regex", "rust", "vim", "vimdoc" }

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then return end

    if vim.treesitter.query.get(lang, "highlights") then vim.treesitter.start(args.buf) end

    if vim.treesitter.query.get(lang, "indents") then
      vim.opt_local.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'
    end

    if vim.treesitter.query.get(lang, "folds") then
      -- vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})
