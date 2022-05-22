local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 1,
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require "notify"
      end,
    }

    use {
      "sainnhe/everforest",
      config = function()
        vim.g.everforest_better_performance = 1
        vim.cmd "colorscheme everforest"
      end,
      disable = false,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      requires = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
      },
      config = function()
        require("config.neogit").setup()
      end,
    }

    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Better surround
    use { "tpope/vim-surround", event = "InsertEnter" }
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'

    -- Buffer
    use { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } }

    -- NVIM Tree
    use {
      "kyazdani42/nvim-tree.lua",
      opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Terminal
    use {"akinsho/toggleterm.nvim", tag = 'v1.*',
    config = function()
      require("toggleterm").setup()
    end}

    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
    }

    -- Easy motion
    use {
      "phaazon/hop.nvim",
      config = function()
        require("config.hop").setup()
      end,
    }

    -- FZF
    use { "junegunn/fzf", run = "./install --all", event = "VimEnter", disable = true }
    use { "junegunn/fzf.vim", event = "BufEnter", disable = true }

    use {
      'nvim-telescope/telescope.nvim',
      opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      cmd = { "Telescope" },
      requires = {
        "nvim-lua/popup.nvim",
        'nvim-lua/plenary.nvim',
        -- "nvim-telescope/telescope-project.nvim",
        -- "nvim-telescope/telescope-smart-history.nvim",
        -- "dhruvmanila/telescope-bookmarks.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
        {
          "ahmedkhalf/project.nvim",
            config = function()
              require("config.project").setup()
            end,
        },
      },
      disable = false,
    }

    -- Some better syntax analysis
    use { 'nvim-treesitter/nvim-treesitter',
      opt = true,
      event = "BufReadPre",
      run = ':TSUpdate',
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects" ,
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-context",
        "p00f/nvim-ts-rainbow",
      },
    }

    -- Performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }
    use { "nathom/filetype.nvim" }


    -- LSP
    use {
      "williamboman/nvim-lsp-installer",
      {
        -- LSP Support
        "neovim/nvim-lspconfig",
        config = function()
          require("config.lsp").setup()
        end,
      }
    }

    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        -- "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "f3fora/cmp-spell",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets", "vim-snippets" },
          config = function()
            require("config.snip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
      },
      disable = false,
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
