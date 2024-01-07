local wk = require("which-key")

local function wrap_cmd(c)
  return ":" .. c .. "<cr>"
end

local mappings = {
  ["<space>"] = { function() require "telescope.builtin".find_files() end, "Find file" },
  ["."] = { function() require "telescope".extensions.file_browser.file_browser() end, "File Browser" },
  ["/"] = { function() require "telescope.builtin".current_buffer_fuzzy_find() end, "Search in file" },
  q = { wrap_cmd("quit"), "Quit" },
  Q = { wrap_cmd("quitall!"), "Quit nvim" },
  L = { wrap_cmd("Lazy"), "Lazy" },
  s = { wrap_cmd("write"), "Save" },
  h = { wrap_cmd("hohlsearch"), "Save" },
  e = { function() require "nvim-tree.api".tree.toggle() end, "File Explorer" },
  ["]"] = { wrap_cmd("bnext \"v:count1\""), "Next buffer" },
  ["["] = { wrap_cmd("bprevious \"v:count1\""), "Prev buffer" },
  b = {
    name = "buffers",
    n = { wrap_cmd("bnext"), "Next buffer" },
    p = { wrap_cmd("bprevious"), "Prev buffer" },
    k = { function() require('bufdelete').bufdelete(0, true) end, "Kill buffer" },
    i = { function() require "telescope.builtin".buffers() end, "List buffers" },
  },
  g = {
    name = "git",
  },
  l = {
    name = "lsp",
    d = { function() require "telescope.builtin".lsp_definitions() end, "Go to definition" },
    D = { vim.lsp.buf.declaration, "Go to declaration" },
    r = { wrap_cmd("Lspsaga rename ++project"), "Rename symbol" },
    f = { vim.lsp.buf.format, "Run code formatter" },
    R = { function() require "telescope.builtin".lsp_references() end, "Show references" },
    a = { wrap_cmd("Lspsaga code_action"), "Show code actions" },
    i = { function() require "telescope.builtin".lsp_implementations() end, "Go to implementation" },
    x = { function() require "telescope.builtin".diagnostics() end, "Go to implementation" },
    s = {
      name = "symbols",
      d = { function() require "telescope.builtin".lsp_document_symbols() end, "Document symbols" },
      w = { function() require "telescope.builtin".lsp_dynamic_workspace_symbols() end, "Workspace symbols" },
    }
  },
  t = { function() require "telescope.builtin".treesitter() end, "Treesitter" },
  w = {
    name = "window",
    h = { wrap_cmd("wincmd h"), "Focus window left" },
    j = { wrap_cmd("wincmd j"), "Focus window down" },
    k = { wrap_cmd("wincmd k"), "Focus window up" },
    l = { wrap_cmd("wincmd l"), "Focus window right" },
    s = { wrap_cmd("split"), "Split window horizontally" },
    v = { wrap_cmd("vsplit"), "Split window vertically" },
    ["+"] = { wrap_cmd("wincmd +"), "Increase window height" },
    ["-"] = { wrap_cmd("wincmd -"), "Decrease window height" },
    [">"] = { wrap_cmd("wincmd >"), "Increase window width" },
    ["<"] = { wrap_cmd("wincmd <"), "Decrease window width" },
    ["="] = { wrap_cmd("wincmd ="), "Equalize all windows" },
  },
}

vim.keymap.set("n", "K", wrap_cmd("Lspsaga hover_doc"), { noremap = true, silent = true, desc = "Hover Symbol" })

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
vim.api.nvim_set_keymap("n", "X", "\"_d", { noremap = true, silent = true, desc = "Go to beginning" })
vim.api.nvim_set_keymap("n", "<c-h>", "^", { noremap = true, silent = true, desc = "Go to beginning" })
vim.api.nvim_set_keymap("n", "<c-l>", "$", { noremap = true, silent = true, desc = "Go to beginning" })

wk.register(mappings, {
  mode = "n",
  prefix = "<leader>",
})
wk.register(mappings, {
  mode = "v",
  prefix = "<leader>",
})
