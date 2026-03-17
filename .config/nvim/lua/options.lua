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
vim.o.conceallevel = 2

vim.diagnostic.config({ signs = false })

vim.api.nvim_create_augroup("AMythicDev/nvim", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.dart", "*.py" },
  group = "AMythicDev/nvim",
  callback = function()
    vim.opt_local.colorcolumn = "80"
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.rs",
  group = "AMythicDev/nvim",
  callback = function()
    vim.opt_local.colorcolumn = "100"
  end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "\\[CodeCompanion\\] *",
  group = "AMythicDev/nvim",
  callback = function(ev)
    vim.opt_local.winfixwidth = true
  end
})

vim.api.nvim_set_hl(0, "FlashLabel", { fg = "white", bold = true })

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params
    .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
