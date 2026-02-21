return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",      
          icons_enabled = true,      
          globalstatus = true,       
        },
        sections = {
          lualine_a = { "mode" },     -- Current mode 
          lualine_b = { "branch" },    -- Git branch
          lualine_c = { "filename" },  -- Current file name
          lualine_x = { "diagnostics" }, -- LSP errors/warnings
          lualine_y = { "progress" },  -- Progress in file (%)
          lualine_z = { "location" }   -- Line number
        },
        extensions = { "neo-tree" }   -- Works with neo-tree
      })
    end,
  },
}
