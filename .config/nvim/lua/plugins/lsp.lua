require "mason"
local capabilities = require('blink.cmp').get_lsp_capabilities();

local ENABLED_LSPS = {
  "astro-language-server",
  "black",
  "clang-format",
  "clangd",
  "gopls",
  "json-lsp",
  "lua-language-server",
  "mesonlsp",
  "python-lsp-server",
  "ruff",
  "rust-analyzer",
  "svelte-language-server",
  "tailwindcss-language-server",
  "typescript-language-server",
  "vtsls",
  "vue-language-server",
  "zls",
}

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

local vtls_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vtls_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

vim.lsp.config('vtsls', {
  capabilities = capabilities,
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
})

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      }
    }
  }
}
)

vim.lsp.config("lua_ls", {
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
})

vim.lsp.enable(ENABLED_LSPS)
