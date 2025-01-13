local packages = {
  { "folke/lazy.nvim" },

  {
    "lewis6991/impatient.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme carbonfox")
    end
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = "0.1.x",
    dependencies = { 'nvim-lua/plenary.nvim', "telescope-fzf-native.nvim" },
    lazy = true,
    config = function() require "plugins.telescope_conf" end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
  },

  {
    'numToStr/Comment.nvim',
    config = true,
    opts = {
      toggler = {
        ---Line-comment keymap
        line = '<leader>/',
        ---Block-comment keymap
        block = '<leader>*',
      },
      opleader = {
        ---Line-comment keymap
        line = '<leader>/',
        ---Block-comment keymap
        block = '<leader>*',
      },
    },
    keys = {
      { "<leader>/", mode = "n" },
      { "<leader>*", mode = "n" },
      { "<leader>/", mode = "v" },
      { "<leader>*", mode = "v" },
    }
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        save_on_toggle = false,
        sync_on_ui_close = false,
      }
    },
  },

  {
    "rafamadriz/friendly-snippets",
    event = { "InsertEnter" },
  },

  {
    "folke/neodev.nvim",
    ft = "lua",
    opts = {},
  },

  {
    "famiu/bufdelete.nvim",
    lazy = true,
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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require "plugins.lualine_config"
    end,
    event = "VeryLazy",
  },

  {
    'linrongbin16/lsp-progress.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lsp-progress').setup()
    end,
    lazy = true,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPre",
    config = function() require "plugins.treesitter" end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function() require "plugins.lsp" end,
  },

  {
    'saghen/blink.cmp',
    version = "*",
    config = function() require "plugins.completion" end,
    event = "InsertEnter",
    dependencies = { "nvim-web-devicons", "lspkind.nvim" }
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = true
  },

  {
    "max397574/better-escape.nvim",
    opts = true,
    event = "InsertEnter",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      whitespace = { highlight = { "Normal" } }
    },
    event = "BufRead",
  },

  {
    "onsails/lspkind.nvim",
    lazy = true,
  },

  {
    'rcarriga/nvim-notify',
    event = "VeryLazy",
    config = function()
      vim.notify = require "notify"
      require "notify".setup()
    end
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      search = {
        exclude = {
          "notify",
          "cmp_menu",
          "noice",
          "flash_prompt",
          function(win)
            -- exclude non-focusable windows
            return not vim.api.nvim_win_get_config(win).focusable
          end,
          "NvimTree",
        },
      },
      jump = {
        autojump = true,
      },
    },
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
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
    "williamboman/mason-lspconfig.nvim",
    lazy = true
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
    'echasnovski/mini.nvim',
    version = '*',
    event = "VeryLazy",
    config = function() require "plugins.mini" end,
  },

}

require "lazy".setup(packages)
