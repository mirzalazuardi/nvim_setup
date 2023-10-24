require ('packer').startup(function(use)
	-- packer can manage itself
	-- :PackerSync
	use 'wbthomason/packer.nvim'

  --whichkey
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

  -- chatgpt
  use({
    "jackMort/ChatGPT.nvim",
      config = function()
        require("chatgpt").setup()
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      }
  })

  -- octo github
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
  use "sindrets/diffview.nvim"

  -- git blame
  use 'f-person/git-blame.nvim'

  -- colorscheme
  use 'tjdevries/colorbuddy.vim'
  use 'tjdevries/gruvbuddy.nvim'

  -- neoformat
  use 'sbdchd/neoformat'

  -- persisted
  use {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup()
    end,
  }

  -- surround
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  }

  -- oneterm
  use 'LoricAndre/OneTerm.nvim'

  -- git fugitive
  use 'tpope/vim-fugitive'

  -- indent blank line
  use "lukas-reineke/indent-blankline.nvim"

  -- hop
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
	use 'nvim-tree/nvim-tree.lua'

	-- telescope
	-- <leader>ff <leader>fg <leader>fb <leader>fh <leader>fs <leader>fc
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- FZF
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
end)
