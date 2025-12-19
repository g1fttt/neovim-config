return {
  "j-hui/fidget.nvim",
  version = "1.6.1",
  opts = {
    progress = {
      display = {
        done_icon = "󰄳",
        overrides = {
          rust_analyzer = { name = "rust-analyzer" },
          lua_ls = { name = "lua-ls" },
          vue_ls = { name = "vue-ls" },
          vtsls = { name = "vue-ts-ls" },
          superhtml = { name = "super-html" },
        },
      },
    },
    notification = {
      window = {
        winblend = 0,
        y_padding = 1,
      },
    },
  },
}
