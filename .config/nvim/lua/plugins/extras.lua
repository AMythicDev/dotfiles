return {
  { "folke/lazy.nvim" },

  {
    "rafamadriz/friendly-snippets",
    event = { "InsertEnter" },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },

  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = true,
    lazy = true,
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {},
  },

  {
    "onsails/lspkind.nvim",
    lazy = true,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = "nvim-treesitter",
    event = "BufReadPre"
  },

  {
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
    event = "BufReadPre",
    dependencies = "nvim-treesitter"
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  {
    "folke/trouble.nvim",
    event = "LspAttach",
    opts = true
  },

  {
    "folke/todo-comments.nvim",
    event = { "BufRead", "BufNewFile" },
    opts = true,
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true,
    event = "VeryLazy"
  },

  {
    "nvimdev/lspsaga.nvim",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      }
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    event = "LspAttach",
  },

  {
    "williamboman/mason.nvim",
    config = true,
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonUninstallAll", "MasonLog" }
  },

  {
    "norcalli/nvim-colorizer.lua",
    ft = { "html", "css", "vue", "javascript" },
    config = function()
      require "colorizer".setup()
    end
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    'nvim-flutter/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {},
    ft = "dart"
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bufdelete = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true },
      explorer = {
        enabled = true,
        replace_netrw = true,
        git_status = true,
      },
      words = {
        enabled = true,
      },
      terminal = {
        enabled = true,
      }
    },
  },

  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      -- downloads a prebuilt binary or falls back to cargo build
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      debug = {
        enabled = true,
        show_scores = true,
        show_file_info = {
          full_path = false,
          timings = false,
        }
      },
      layout = {
        prompt_position = "top",
      },
    },
    lazy = false, -- the plugin lazy-initialises itself
  },

  {
    "folke/noice.nvim",
    keys = { ":", "/", "?" },
    opts = {
      cmdline = {
        enabled = true,
        opts = {
          position = { row = "10%", col = "50%" }
        }
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
  },

  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",             -- use latest release, remove to use latest commit
    opts = {
      legacy_commands = false, -- this will be removed in 4.0.0
      picker = {
        name = "snacks.picker",
      },
      frontmatter = { enabled = false },
      completion = {
        lsp = true,
      },
      unique_note = {
        format = "YYYY-MM-DD HHmm",
        template = "Note.md",
      },
      templates = {
        folder = "Templates/"
      },
      workspaces = {
        {
          name = "The Brain",
          path = "~/The Brain/",
        },
      },
    },
  },
}
