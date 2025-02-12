local lspconfig = require('lspconfig')

require "mason".setup()
require "mason-lspconfig".setup()

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("Ad/LSPFormat", { clear = true }),
  callback = function()
    local filter = { bufnr = vim.api.nvim_get_current_buf() }
    local client = vim.lsp.get_clients(filter)[1]
    if client and client.server_capabilities['documentFormattingProvider'] then
      vim.lsp.buf.format()
    end
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities();

require "mason-lspconfig".setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,

  ["rust_analyzer"] = function()
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
  end,

  ["lua_ls"] = function()
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
  end,
})

require 'lspconfig'.dartls.setup {
  cmd = { "dart", 'language-server', '--protocol=lsp' },
}
