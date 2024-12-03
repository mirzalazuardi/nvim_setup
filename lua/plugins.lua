require ('packer').startup(function(use)
	-- packer can manage itself
	-- :PackerSync
	use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use "lukas-reineke/lsp-format.nvim"
  use 'wincent/ferret'
  use "github/copilot.vim"
  -- use { "zbirenbaum/copilot.lua" }
  
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }

  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

  use {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',  -- Switch to the main branch
    event = 'VimEnter',
    config = function()
      require('CopilotChat').setup({
        debug = true,
        show_help = 'yes',
        prompts = {
          Explain = 'Explain how it works in English.',
          Review = 'Review the following code and provide concise suggestions.',
          Tests = 'Briefly explain how the selected code works, then generate unit tests.',
          Refactor = 'Refactor the code to improve clarity and readability.',
        },
        -- Proxy setting omitted to use a direct connection
      })
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'github/copilot.vim' },  -- Alternatively, use 'zbirenbaum/copilot.lua'
    },
    build = 'make tiktoken',  -- Only on macOS or Linux
  }

  use {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  use {
    'isak102/telescope-git-file-history.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',

    }
  }

  --dash
  use 'rizzatti/dash.vim'
  --emmet
  use 'mattn/emmet-vim'

  -- nvim-colorizer
  use 'norcalli/nvim-colorizer.lua'

  --vim-rest-console
  -- :ft=rest
  -- https://reqres.in
  -- GET /api/users?page=2
  -- <c-j>
  use 'diepm/vim-rest-console'

  --whichkey
  --<leader>f<space>
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  
  -- DAP
  use 'mfussenegger/nvim-dap'
  use 'suketa/nvim-dap-ruby'

  -- chatgpt
  -- :ChatGPT
  -- use({
  --   "jackMort/ChatGPT.nvim",
  --     config = function()
  --       require("chatgpt").setup()
  --     end,
  --     requires = {
  --       "MunifTanjim/nui.nvim",
  --       "nvim-lua/plenary.nvim",
  --       "nvim-telescope/telescope.nvim"
  --     }
  -- })

  -- octo github
  -- :Octo pr list
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }
  
  -- diffview
  -- :DiffViewOpen
  use "sindrets/diffview.nvim"

  -- git blame
  use 'f-person/git-blame.nvim'

  -- colorscheme
  use 'tjdevries/colorbuddy.vim'
  use 'tjdevries/gruvbuddy.nvim'

  -- neoformat
  -- :NeoFormat
  use 'sbdchd/neoformat'

  -- persisted
  -- :SessionStart
  use {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup()
    end,
  }

  -- surround
  -- cs"'
  use {
    'kylechui/nvim-surround',
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  }

  -- oneterm
  -- :OneTerm ranger
  use 'LoricAndre/OneTerm.nvim'

  -- git fugitive
  use 'tpope/vim-fugitive'

  -- rails
  use 'tpope/vim-rails'

  -- indent blank line
  -- :IBLToggle
  use "lukas-reineke/indent-blankline.nvim"

  -- hop
  -- :HopWord
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

	-- Comment
	-- gcc gbc gcw gc$ gc2j gc4k
	use {
	    'numToStr/Comment.nvim',
	    config = function()
		require('Comment').setup()
	    end
	}

	-- mason
	-- :MasonUpdate
	-- :MasonInstall ruby-lsp
	use {
		"williamboman/mason.nvim",
		run = ":MasonUpdate" -- :MasonUpdate updates registry
	}

	-- alpha-nvim
	use {
		'goolord/alpha-nvim',
		requires = {'nvim-tree/nvim-web-devicons'},
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.config)
		end
	}
	
	-- nvim-cmp - completions engine
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use "rafamadriz/friendly-snippets"

	-- git-signs
  use{
        "lewis6991/gitsigns.nvim",
        config = function()
            require("configs.gitsigns")
        end,
  }
	-- Lualine
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	
	-- nvim-visual-multi
	-- <C-n> n N q Q
	use 'mg979/vim-visual-multi'

	-- nvim-tree.lua
  -- https://docs.rockylinux.org/books/nvchad/nvchad_ui/nvimtree/
  -- :NvimTreeFindFileToggle
	use 'nvim-tree/nvim-tree.lua'

	-- telescope
	-- <leader>ff <leader>fg <leader>fb <leader>fh <leader>fs <leader>fc
	use {
        'nvim-telescope/telescope.nvim',
	  -- 'nvim-telescope/telescope.nvim', tag = '0.1.4',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- FZF
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end)
