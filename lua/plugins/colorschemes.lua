return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    priority = 1000,
    lazy = false,
    config = function()
      require("ui.theme").setup()
      vim.cmd.colorscheme("seoulbones")
    end,
  },
}
