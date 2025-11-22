vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.background = "dark"
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.g.zig_fmt_autosave = 0
vim.o.splitright = true
vim.o.splitbelow = false

vim.api.nvim_create_augroup("AMythicDev/nvim", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.dart", "*.py" },
  group = "AMythicDev/nvim",
  callback = function()
    vim.cmd [[set colorcolumn=80]]
  end
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.rs",
  group = "AMythicDev/nvim",
  callback = function()
    vim.cmd [[set colorcolumn=100]]
  end
})
