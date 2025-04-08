vim.cmd [[packadd packer.nvim]] -- garante que o packer esteja carregado

return require("packer").startup(function(use)
  -- Plugin manager
  use "wbthomason/packer.nvim"
 

  -- Autopairs (ajustado com integração nvim-cmp se tiver)
  use {
    "windwp/nvim-autopairs",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({})

      -- Integra com nvim-cmp (caso esteja usando)
      local cmp_status, cmp = pcall(require, "cmp")
      if cmp_status then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end
  }

  use {
    '0x00-ketsu/autosave.nvim',
    config = function()
      require('autosave').setup(
        {
            enable = true,
            prompt = {
                enable = true,
                style = 'stdout',
                message = function()
                return 'Autosave: saved at ' .. vim.fn.strftime('%H:%M:%S')
                end,
            },
            events = {'InsertLeave', 'TextChanged'},
            conditions = {
                exists = true,
                modifiable = true,
                filename_is_not = {},
                filetype_is_not = {}
            },
            write_all_buffers = false,
            debounce_delay = 135
        }
    )
    end
  }

  -- Discord Rich Presence
  use {
    "IogaMaster/neocord",
    config = function()
      require("neocord").setup({
        logo                = "auto",
        logo_tooltip        = nil,
        main_image          = "language",
        client_id           = "1157438221865717891",
        debounce_timeout    = 10,
        show_time           = true,

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

  -- NvimTree (explorador de arquivos lateral estilo VSCode)
   -- NvimTree (explorador de arquivos lateral estilo VSCode)
   use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local present, nvimtree = pcall(require, "nvim-tree")
      if not present then return end

      local options = {
        filters = {
          dotfiles = false,
          exclude = { "custom" },
        },
        disable_netrw = true,
        hijack_netrw = true,
        ignore_ft_on_setup = { "alpha" },
        open_on_tab = false,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        update_cwd = true,
        diagnostics = {
          enable = true,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
        view = {
          side = "left",
          width = 25,
          hide_root_folder = true,
        },
        git = {
          enable = false,
          ignore = true,
        },
        actions = {
          open_file = {
            resize_window = true,
          },
        },
        renderer = {
          highlight_git = false,
          highlight_opened_files = "none",
          indent_markers = {
            enable = false,
          },
          icons = {
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = false,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
      }

      nvimtree.setup(options)
    end
  }
  -- Terminal flutuante com Ctrl + j
  use {
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      -- Corrige o caminho do shell
      vim.opt.shell = '"C:/Program Files/Git/bin/bash.exe"'
      vim.opt.shellcmdflag = "--login -i -c"
      vim.opt.shellquote = ""
      vim.opt.shellxquote = ""
  
      require("toggleterm").setup {
        size = 10,
        open_mapping = [[<C-j>]], -- atalho Ctrl + j
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 3,
        },
      }
    end
  }
  
  


  -- Tema Oxocarbon
 -- ...

 use {
  'folke/tokyonight.nvim',
  config = function()
    require("tokyonight").setup({
      style = "day", -- opções: "storm", "moon", "night", "day"
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { italic = true, bold = true },
        variables = { italic = true, bold = true },
      },
    })
    vim.cmd[[colorscheme tokyonight]]
  end
}


-- Removi o bloco oxocarbon aqui (como tu pediu)

-- ...

  -- Syntax Highlight bolado
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      vim.cmd([[TSUpdate]])
    end,
  }

  ----------------------------------------------------------------
  -- 🔮 AutoComplete + AutoImport (funciona com JS/TS também!)
  ---------------------------------------------------------------

  ----------------------------------------------------------------

  -- auto-sync se packer foi recém-instalado
  local packer_bootstrap = false
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
  end

  if packer_bootstrap then
    require("packer").sync()
  end
end)
