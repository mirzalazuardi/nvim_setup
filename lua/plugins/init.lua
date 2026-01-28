return {
  {
    "stevearc/conform.nvim",
    opts = {},
  },

    -- 🧠 OpenCode AI Assistant (right-side positioned)
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- snacks.nvim is already in your config
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    lazy = false,
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Use snacks provider for right-side positioning (like the GitHub video)
        provider = {
          enabled = "snacks",
          snacks = {
            auto_close = true,
            win = {
              position = "right",  -- Position on the right side
              width = math.floor(vim.o.columns * 0.35),  -- 35% of screen width
              enter = false,  -- Stay in editor after opening
              wo = {
                winbar = "",
              },
              bo = {
                filetype = "opencode_terminal",
              },
            },
          },
        },
      }
      -- Required for opts.events.reload
      vim.o.autoread = true
      -- Key mappings (keeping your <leader>oo for toggle)
      vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>oo", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      -- Additional useful mappings
      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { expr = true, desc = "Add range to opencode" })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })
    end,
  },

  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "sindrets/diffview.nvim",
    },
    build = function()
      require("gitlab.server").build(true)
    end,
    config = function()
      require("gitlab").setup({
        -- optional config, see :help gitlab.nvim
      })
    end,
    keys = {
      { "<leader>gm", function() require("gitlab").choose_merge_request() end, desc = "GitLab: Choose MR" },
      { "<leader>gr", function() require("gitlab").review() end, desc = "GitLab: Review MR" },
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
  },
  { "melopilosyan/rspec-integrated.nvim", lazy = true },
  {
    "vim-scripts/loremipsum",
    lazy = false,
  },
  {
    "github/copilot.vim",
    lazy = false,
  },
  {
    "phaazon/hop.nvim",
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "tpope/vim-rails",
    lazy = false,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  {
    "tpope/vim-surround",
    lazy = false,
  },

  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {
      -- add any options here
    },
  },

  {
    "yetone/avante.nvim",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has "win32" ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- for example
      provider = "claude",
      providers = {
        -- 🌐 Cloud providers (require API keys & internet)
        gemini = {
          model = "gemini-1.5-pro",
          api_key_name = "AVANTE_GEMINI_API_KEY",
          timeout = 30000,
          temperature = 0,
          max_completion_tokens = 8192,
        },
        openai = {
          endpoint = "https://api.openai.com/v1",
          api_key_name = "AVANTE_OPEN_AI_API_KEY",
          model = "gpt-4o",
        },
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514",
          api_key_name = "AVANTE_ANTHROPIC_API_KEY",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        moonshot = {
          endpoint = "https://api.moonshot.ai/v1",
          model = "kimi-k2-0711-preview",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 32768,
          },
        },
        deepseek = {
          __inherited_from = "openai",
          endpoint = "https://api.deepseek.com/v1/chat/completions",
          api_key_name = "AVANTE_DEEPSEEK_API_KEY",
          model = "deepseek-coder",
        },
        -- 🏠 Local Ollama provider (free, no API key needed)
        ollama = {
          endpoint = "http://127.0.0.1:11434/v1",
          -- model = "qwen2.5-coder:7b", -- Fast coding model, or use "llama3.1", "deepseek-coder-v2"
          model = "llama3:latest", -- Fast coding model, or use "llama3.1", "deepseek-coder-v2"
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint .. "/chat/completions",
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
              },
              body = {
                model = opts.model,
                messages = require("avante.providers").copilot.parse_message(code_opts),
                max_tokens = 8192,
                stream = true,
                temperature = 0.7,
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").openai.parse_response(data_stream, event_state, opts)
          end,
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
        "ruby", "python", "javascript", "typescript",
        "markdown", "markdown_inline",
        "json", "yaml", "toml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true,
      mode = "cursor",
      separator = "-",
      max_lines = 3,
      trim_scope = "center",
      border = "none",
    },
  },
}
