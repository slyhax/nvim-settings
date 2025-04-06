vim.cmd [[packadd packer.nvim]] -- garante que o packer esteja carregado

return require("packer").startup(function(use)
  -- Plugin manager
  use "wbthomason/packer.nvim"

  -- Discord Rich Presence
  use {
    "IogaMaster/neocord",
    config = function()
      require("neocord").setup({
        -- General options
        logo                = "auto", 
        logo_tooltip        = nil,
        main_image          = "language",
        client_id           = "1157438221865717891",
        log_level           = nil,
        debounce_timeout    = 10,
        blacklist           = {},
        file_assets         = {},
        show_time           = true,
        global_timer        = false,

        -- Rich Presence text options
        editing_text        = "Editing %s",
        file_explorer_text  = "Browsing %s",
        git_commit_text     = "Committing changes",
        plugin_manager_text = "Managing plugins",
        reading_text        = "Reading %s",
        workspace_text      = "Working on %s",
        line_number_text    = "Line %s out of %s",
        terminal_text       = "Using Terminal",
      })
    end
  }

  -- Arquivo Explorer lateral
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
          relativenumber = true,
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              folder = true,
              file = true,
              git = true,
            },
          },
        },
      })

      -- Ctrl + B → Foca no NvimTree
      vim.keymap.set('n', '<C-b>', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
      -- Ctrl + Shift + B → Abre/fecha o NvimTree
      vim.keymap.set('n', '<C-S-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
  }

  -- Tema escuro clean com negrito + itálico (tokyonight)
  use {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_style = "storm"
      vim.g.tokyonight_italic_functions = true
      vim.g.tokyonight_italic_keywords = true
      vim.g.tokyonight_italic_variables = true
      vim.g.tokyonight_bold = true
      vim.cmd("set termguicolors")
      vim.cmd("colorscheme tokyonight-storm") -- opções: night, storm, moon, day
    end
  }

  -- Syntax Highlight bolado
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      vim.cmd([[TSUpdate]])
    end,
  }

  -- auto-sync se packer foi recém-instalado
  if packer_bootstrap then
    require("packer").sync()
  end
end)
