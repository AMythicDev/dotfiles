local packages = {
  { "folke/lazy.nvim" },

  {
    "lewis6991/impatient.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "folke/tokyonight.nvim",
    config = function()
      require "plugins.tokynight_conf"
      vim.cmd("colorscheme tokyonight")
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
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    cmd = { "Telescope file_browser" },
    keys = { "<leader>." },
    config = function()
      require("telescope").load_extension "file_browser"
    end
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
  },

  {
    'numToStr/Comment.nvim',
    config = true,
    keys = {
      { "gc", mode = "n" },
      { "gb", mode = "n" },
      { "gc", mode = "v" },
      { "gb", mode = "v" },
    }
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
    "hrsh7th/nvim-cmp",
    config = function() require "plugins.completion" end,
    event = "InsertEnter",
    dependencies = { "nvim-web-devicons", "lspkind.nvim" }
  },

  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function() require"plugins.snippets" end,
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" }
  },

  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = "LuaSnip",
    event = "InsertEnter",
  },

  {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = "nvim-lspconfig",
    event = "LspAttach",
  },

  {
    "hrsh7th/cmp-buffer",
    event = "InsertEnter",
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
        whitespace = { highlight = {"Normal"} }
    },
    event = "BufRead",
  },

  {
    "FelipeLema/cmp-async-path",
    lazy = true,
  },

  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    event = "LspAttach",
  },

  {
    "hrsh7th/cmp-cmdline",
    keys = { ":" }
  },

  { "hrsh7th/cmp-path", lazy = true },

  {
    "petertriho/cmp-git",
    dependencies = "plenary.nvim",
    config = function()
      require "cmp_git".setup {}
    end,
    ft = "gitcommit",
  },

  { "onsails/lspkind.nvim", lazy = true },

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
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = "n" },
      { "S", mode = "n" },
      { "s", mode = "v" },
      { "S", mode = "v" },
    },
    config = function()
      require "leap".add_default_mappings()
    end
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
     config = function ()
       require"colorizer".setup()
     end
  },

  {
    'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async',
    config = true,
    lazy = true,
  }
}

require "lazy".setup(packages)
