return {
  -- 1. Keep the startup menu, but replace the "LazyVim" banner
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          -- Replaces the "LazyVim Z z z" banner with standard Neovim logo
          -- (Set to "" if you want no header at all, just the menu buttons)
          header = [[
   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
        },
      },
    },
  },

  -- 2. Move cmdline back to the bottom (classic Vim style)
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
      },
    },
  },

  -- 3. Streamlined / stripped status bar
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Remove the clock
      opts.sections.lualine_z = {}

      -- Keep line:column coordinates, drop redundant file percentage
      opts.sections.lualine_y = {
        { "location", padding = { left = 1, right = 1 } },
      }

      -- Remove git diff counts and lazy update alerts (retain macro recording & command info)
      opts.sections.lualine_x = {
        Snacks.profiler.status(),
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = function() return { fg = Snacks.util.color("Statement") } end,
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return { fg = Snacks.util.color("Constant") } end,
        },
      }

      -- Remove the workspace root directory indicator from the left
      opts.sections.lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = LazyVim.config.icons.diagnostics.Error,
            warn = LazyVim.config.icons.diagnostics.Warn,
            info = LazyVim.config.icons.diagnostics.Info,
            hint = LazyVim.config.icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      }
    end,
  },
}
