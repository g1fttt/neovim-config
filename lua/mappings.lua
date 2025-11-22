local M = {}

function M.on_lsp_attach()
  require("which-key").add({
    {
      group = "LSP",
      icon = {
        icon = "",
        color = "cyan",
      },
      { "<leader>lD", "<CMD>FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics", },
      { "<leader>li", "<CMD>FzfLua lsp_implementations<CR>",   desc = "Implementations" },
      { "<leader>lS", "<CMD>FzfLua lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
      { "<leader>a",  "<CMD>FzfLua lsp_code_actions<CR>",      desc = "Code actions" },
      { "<leader>k",  vim.lsp.buf.hover,                       desc = "Documentation hover" },
      { "<leader>gd", vim.lsp.buf.definition,                  desc = "Go to definition" },
      { "<leader>ld", vim.diagnostic.open_float,               desc = "Diagnostic hover" },
    },
  })
end

function M.blink_cmp()
  return {
    preset = "enter",

    ["<Esc>"] = { "cancel", "fallback" },
  }
end

M.spec = {
  { "<leader>",  "<Nop>",           silent = true },

  { "<leader>/", ":normal gcc<CR>", desc = "Comment line" },
  {
    "<leader>/",
    "<Esc>:normal gvgc<CR>",
    mode = "v",
    desc = "Comment block"
  },
  { "<Esc>",     "<CMD>nohlsearch<CR>", silent = true },

  { "<leader>o", "<CMD>Oil<CR>",        desc = "Open current directory as a buffer" },
  {
    "<leader>tl",
    function()
      local current_dir = vim.fn.expand("%:p:h")

      vim.g.is_live_server_active = not vim.g.is_live_server_active

      require("live-server").toggle(current_dir)
    end,
    desc = "Toggle live server"
  },
  { "<leader>tm", "<CMD>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
  {
    "<leader>lg",
    function() Snacks.lazygit.open() end,
    desc = "Open LazyGit",
  },

  {
    group = "FzfLua",
    icon = {
      icon = "󰍉",
      color = "blue",
    },
    { "<leader>f", "<CMD>FzfLua files<CR>",  desc = "Open file picker" },
    { "<leader>s", "<CMD>FzfLua global<CR>", desc = "Open global search" },
    {
      "<C-p>",
      function()
        require("fzf-lua.win").toggle_preview()
      end,
      desc = "Toggle file preview",
      mode = "t",
    },
  },

  {
    group = "Buffers",
    icon = {
      icon = "",
      color = "green",
    },
    { "[b",         "<CMD>BufferPrevious<CR>", desc = "Go to next buffer" },
    { "]b",         "<CMD>BufferNext<CR>",     desc = "Go to previous buffer" },
    { "<leader>w",  "<CMD>BufferClose<CR>",    desc = "Close current buffer" },
    { "<leader>g1", "<CMD>BufferGoto 1<CR>",   desc = "Go to buffer 1" },
    { "<leader>g2", "<CMD>BufferGoto 2<CR>",   desc = "Go to buffer 2" },
    { "<leader>g3", "<CMD>BufferGoto 3<CR>",   desc = "Go to buffer 3" },
    { "<leader>g4", "<CMD>BufferGoto 4<CR>",   desc = "Go to buffer 4" },
    { "<leader>g5", "<CMD>BufferGoto 5<CR>",   desc = "Go to buffer 5" },
    { "<leader>g6", "<CMD>BufferGoto 6<CR>",   desc = "Go to buffer 6" },
    { "<leader>g7", "<CMD>BufferGoto 7<CR>",   desc = "Go to buffer 7" },
    { "<leader>g8", "<CMD>BufferGoto 8<CR>",   desc = "Go to buffer 8" },
    { "<leader>g9", "<CMD>BufferGoto 9<CR>",   desc = "Go to buffer 9" },
  },
}

return M
