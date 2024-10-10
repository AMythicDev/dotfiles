local wk = require("which-key")
local functions = require("functions")

local function wrap_cmd(c)
  return ":" .. c .. "<cr>"
end

local mappings = {
  l = {
    name = "lsp",
    d = { function() require "telescope.builtin".lsp_definitions() end, "Go to definition" },
    D = { vim.lsp.buf.declaration, "Go to declaration" },
    r = { wrap_cmd("Lspsaga rename ++project"), "Rename symbol" },
    f = { vim.lsp.buf.format, "Run code formatter" },
    R = { function() require "trouble".toggle("lsp_references") end, "Show references" },
    a = { wrap_cmd("Lspsaga code_action"), "Show code actions" },
    i = { function() require "telescope.builtin".lsp_implementations() end, "Go to implementation" },
    t = { functions.show_diagnostics, "Show diagnostics" },
    s = {
      name = "symbols",
      d = { function() require "telescope.builtin".lsp_document_symbols() end, "Document symbols" },
      w = { function() require "telescope.builtin".lsp_dynamic_workspace_symbols() end, "Workspace symbols" },
    }
  },
}

local mappings = {
  { "<leader><space>", function() require "telescope.builtin".find_files() end,                    desc = "Find file" },
  { "<leader>.",       function() require "telescope.builtin".live_grep() end,                     desc = "Live grap" },
  { "<leader>f",       function() require "telescope.builtin".current_buffer_fuzzy_find() end,     desc = "Find" },
  { "<leader>q",       wrap_cmd("quit"),                                                           desc = "Quit" },
  { "<leader>Q",       wrap_cmd("quitall!"),                                                       desc = "Quit nvim" },
  { "<leader>L",       wrap_cmd("Lazy"),                                                           desc = "Lazy" },
  { "<leader>s",       wrap_cmd("write"),                                                          desc = "save" },
  { "<leader>e",       function() require "nvim-tree.api".tree.toggle() end,                       desc = "File Explorer" },
  { "<leader>w",       proxy = "<c-w>",                                                            group = "windows" },
  { "<leader>]",       wrap_cmd("bnext \"v:count1\""),                                             desc = "Next buffer" },
  { "<leader>[",       wrap_cmd("bprevious \"v:count1\""),                                         desc = "Prev buffer" },
  { "<leader>b",       group = "buffers", },
  { "<leader>bn",      wrap_cmd("bnext"),                                                          desc = "Next" },
  { "<leader>bp",      wrap_cmd("bprevious"),                                                      desc = "Prev" },
  { "<leader>bk",      function() require('bufdelete').bufdelete(0, true) end,                     desc = "Kill" },
  { "<leader>bl",      function() require "telescope.builtin".buffers() end,                       desc = "List" },
  { "<leader>h",       group = "harpoon", },
  { "<leader>ha",      function() require("harpoon"):list():append() end,                          desc = "Add to list" },
  { "<leader>hp",      function() require("harpoon"):list():prev() end,                            desc = "Prev buffer" },
  { "<leader>hn",      function() require("harpoon"):list():next() end,                            desc = "Next buffer" },
  { "<leader>h1",      function() require("harpoon"):list():select(1) end,                         desc = "Buffer 1" },
  { "<leader>h2",      function() require("harpoon"):list():select(2) end,                         desc = "Buffer 2" },
  { "<leader>h3",      function() require("harpoon"):list():select(3) end,                         desc = "Buffer 3" },
  { "<leader>h4",      function() require("harpoon"):list():select(4) end,                         desc = "Buffer 4" },
  { "<leader>h5",      function() require("harpoon"):list():select(5) end,                         desc = "Buffer 5" },
  { "<leader>he",      function() functions.harpoon_menu() end,                                    desc = "Show harpoon" },
  { "<leader>l",       group = "lsp", },
  { "<leader>ld",      function() require "telescope.builtin".lsp_definitions() end,               desc = "Go to definition" },
  { "<leader>lD",      vim.lsp.buf.declaration,                                                    desc = "Go to declaration" },
  { "<leader>lr",      wrap_cmd("Lspsaga rename ++project"),                                       desc = "Rename symbol" },
  { "<leader>lf",      vim.lsp.buf.format,                                                         desc = "Run code formatter" },
  { "<leader>lR",      function() require "trouble".toggle("lsp_references") end,                  desc = "Show references" },
  { "<leader>la",      wrap_cmd("Lspsaga code_action"),                                            desc = "Show code actions" },
  { "<leader>li",      function() require "telescope.builtin".lsp_implementations() end,           desc = "Go to implementation" },
  { "<leader>lt",      functions.show_diagnostics,                                                 desc = "Show diagnostics" },
  { "<leader>ls",      group = "symbols", },
  { "<leader>lsd",     function() require "telescope.builtin".lsp_document_symbols() end,          desc = "Document symbols" },
  { "<leader>lsw",     function() require "telescope.builtin".lsp_dynamic_workspace_symbols() end, desc = "Workspace symbols" },
  { "<leader>t",       group = "treesitter" },
  { "<leader>tt",      function() require "telescope.builtin".treesitter() end,                    desc = "Treesitter telescope" },
}

vim.keymap.set("n", "K", wrap_cmd("Lspsaga hover_doc"), { noremap = true, silent = true, desc = "Hover Symbol" })
vim.keymap.set({ "n", "v", "i" }, "<up>", "<Nop>", {})
vim.keymap.set({ "n", "v", "i" }, "<down>", "<Nop>", {})
vim.keymap.set({ "n", "v", "i" }, "<right>", "<Nop>", {})
vim.keymap.set({ "n", "v", "i" }, "<left>", "<Nop>", {})

vim.keymap.set("i", "<c-h>", "<left>", { noremap = true })
vim.keymap.set("i", "<c-j>", "<down>", { noremap = true })
vim.keymap.set("i", "<c-k>", "<up>", { noremap = true })
vim.keymap.set("i", "<c-l>", "<right>", { noremap = true })

vim.api.nvim_set_keymap("n", "<c-h>", wrap_cmd("wincmd h"), { noremap = true, silent = true, desc = "Focus left window" })

vim.api.nvim_set_keymap("n", "<c-j>", wrap_cmd("wincmd j"),
  { noremap = true, silent = true, desc = "Focus bottom window" })
vim.api.nvim_set_keymap("n", "<c-k>", wrap_cmd("wincmd k"), { noremap = true, silent = true, desc = "Focus up window" })
vim.api.nvim_set_keymap("n", "<c-l>", wrap_cmd("wincmd l"),
  { noremap = true, silent = true, desc = "Focus right window" })
vim.api.nvim_set_keymap("n", "<c-right>", wrap_cmd("wincmd >"),
  { noremap = true, silent = true, desc = "Increase width" })
vim.api.nvim_set_keymap("n", "<c-left>", wrap_cmd("wincmd <"), { noremap = true, silent = true, desc = "Decrease width" })
vim.api.nvim_set_keymap("n", "<c-up>", wrap_cmd("wincmd +"), { noremap = true, silent = true, desc = "Increase height" })
vim.api.nvim_set_keymap("n", "<c-down>", wrap_cmd("wincmd -"),
  { noremap = true, silent = true, desc = "Decrease height" })

vim.api.nvim_set_keymap("n", "X", "\"_d", { noremap = true, silent = true, desc = "Delete" })

vim.api.nvim_set_keymap("n", "<c-h>", "^", { noremap = true, silent = true, desc = "Go to beginning" })
vim.api.nvim_set_keymap("n", "<c-l>", "$", { noremap = true, silent = true, desc = "Go to end" })

wk.add(mappings)
