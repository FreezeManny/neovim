return {
  -- Disable LazyVim's default colorschemes
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },

  -- Atom's "One Dark" theme
  {
    "navarasu/onedark.nvim",
    opts = {
      -- style: dark | darker | cool | deep | warm | warmer | light
      style = "darker",
    },
  },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
