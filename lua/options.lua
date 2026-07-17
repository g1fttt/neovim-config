return {
  opt = {
    number = true,
    relativenumber = true,
    swapfile = false,
    cursorline = true,
    termguicolors = true,
    wrap = false,
    signcolumn = "yes",
    undofile = true,
    hlsearch = true,
    colorcolumn = "100",
    background = "dark",
  },
  o = {
    expandtab = true,
    shiftwidth = 2,
    softtabstop = 2,
    tabstop = 2,
    winborder = "single",
  },
  g = {
    mapleader = " ",
    maplocalleader = " ",
    colors_name = "seoulbones",
    rustaceanvim = require("options.rustaceanvim"),
  },
  extras = {
    transparency = false,
  },
}
