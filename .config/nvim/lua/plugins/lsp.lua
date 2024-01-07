local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("Ad/LSPFormat", { clear = true }),
  callback = function()
    local filter = { bufnr = vim.api.nvim_get_current_buf() }
    local client = vim.lsp.get_active_clients(filter)[1]
    if client and client.server_capabilities['documentFormattingProvider'] then
      vim.lsp.buf.format()
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("Ad/Diagnostics", { clear = true }),
  callback = function()
    local current_win = vim.api.nvim_get_current_win()

    local trouble = require "trouble"

    if vim.tbl_isempty(vim.diagnostic.get()) then
      trouble.close()
    else
      trouble.open()
      vim.api.nvim_set_current_win(current_win)
    end
  end
})

lspconfig.rust_analyzer.setup {
  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      }
    }
  }
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      completion = {
        callSnippet = "Replace"
      }
    }
  }
}

lspconfig.zls.setup {
  capabilities = capabilities,
}
