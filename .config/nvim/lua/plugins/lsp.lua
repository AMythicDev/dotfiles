local lspconfig = require('lspconfig')

require "mason".setup()
require "mason-lspconfig".setup()

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("AMythicDev/LSPFormat", { clear = true }),
  callback = function()
    local filter = { bufnr = vim.api.nvim_get_current_buf() }
    local client = vim.lsp.get_clients(filter)[1]
    if client and client.server_capabilities['documentFormattingProvider'] then
      vim.lsp.buf.format()
    end
  end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities();

local vtls_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vtls_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

local vue_ls_config = {}

vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.enable({ 'vtsls', 'vue_ls' })

require "mason-lspconfig".setup({
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
