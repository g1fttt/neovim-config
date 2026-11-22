local M = {}

function M.on_lsp_attach()
  require("which-key").add({
    {
      group = "LSP",
      icon = {
        icon = "󰁥",
        color = "cyan",
      },
      {
        "<leader>I",
        function() Snacks.picker.lsp_implementations() end,
        desc = "Struct/class implementations"
      },
      { "<leader>a", vim.lsp.buf.code_action,   desc = "Code actions" },
      { "<leader>k", vim.lsp.buf.hover,         desc = "Documentation hover" },
      { "<leader>d", vim.diagnostic.open_float, desc = "Diagnostic hover" },
      {
        "<leader>D",
        function() Snacks.picker.diagnostics() end,
        desc = "Workspace diagnostics",
      },
      { "<leader>rn", vim.lsp.buf.rename,     desc = "Rename symbol" },
      { "gd",         vim.lsp.buf.definition, desc = "Go to definition" },
    },
  })
end

function M.on_rust_analyzer_attach()
  require("which-key").add({
    {
      group = "Rust",
      icon = {
        icon = "",
        color = "orange",
      },
      { "<leader>re", "<CMD>RustLsp expandMacro<CR>",        desc = "Expand rust macro" },
      { "gr",         "<CMD>RustLsp relatedDiagnostics<CR>", desc = "Go to related diagnostics" },
    }
  })
end

function M.blink_cmp()
  return {
    preset = "enter",

    ["<Esc>"] = { "cancel", "fallback" },
  }
end

function M.for_pros()
  if not require("options").extras.i_am_pro then
    return
  end

  for _, key in pairs({ "<Left>", "<Right>", "<Down>", "<Up>" }) do
    Snacks.keymap.set({ "n", "v" }, key, "<NOP>")
  end
end

M.spec = {
  { "<leader>", "<Nop>",               silent = true },
  { "<Esc>",    "<CMD>nohlsearch<CR>", silent = true },

  {
    mode = "v",
    { "<",        "<gv", },
    { ">",        ">gv", },
    { "<A-k>",    ":move '<-2<CR>gv=gv", desc = "Move selection up", },
    { "<A-j>",    ":move '>+1<CR>gv=gv", desc = "Move selection down", },
    { "<A-Up>",   "<A-k>",               remap = true, },
    { "<A-Down>", "<A-j>",               remap = true, },
  },

  {
    "<leader>o",
    function() require("fyler").toggle() end,
    desc = "Toggle buffer-like file tree",
    icon = {
      icon = "󰐅",
      color = "green",
    },
  },
  {
    "<leader>gw",
    "<CMD>HopWord<CR>",
    desc = "Go (hop) to a word",
    icon = "󱋿",
  },
  {
    "<leader>s",
    function() require("ui.search").open("grep") end,
    desc = "Global search",
    icon = "󰍉",
  },

  {
    icon = "",
    { "<leader>/", ":normal gcc<CR>", desc = "Comment line" },
    {
      "<leader>/",
      "<Esc>:normal gvgc<CR>",
      mode = "v",
      desc = "Comment block"
    },
  },

  {
    icon = {
      icon = "",
      color = "orange",
    },
    {
      "<leader>tl",
      function()
        local current_dir = vim.fn.expand("%:p:h")

        require("live-server").toggle(current_dir)
      end,
      desc = "Toggle live server",
    },
    { "<leader>tm", "<CMD>RenderMarkdown toggle<CR>", desc = "Toggle markdown render" },
  },

  {
    icon = {
      icon = "󰊢",
      color = "red",
    },
    {
      "<leader>lg",
      function() Snacks.lazygit.open() end,
      desc = "Open LazyGit",
    },
    {
      "<leader>ll",
      function() Snacks.lazygit.log_file() end,
      desc = "Open current file log in LazyGit",
    },
    { "<leader>h", "<CMD>Gitsigns preview_hunk_inline<CR>", desc = "Preview git hunk inline" },
  },

  {
    group = "Buffers",
    icon = {
      icon = "",
      color = "green",
    },
    { "[b", "<CMD>BufferPrevious<CR>", desc = "Go to previous buffer" },
    { "]b", "<CMD>BufferNext<CR>",     desc = "Go to next buffer" },
    {
      "<leader>w",
      function()
        if vim.bo.filetype ~= "snacks_dashboard" then
          vim.cmd("BufferClose")
        end
      end,
      desc = "Close current buffer"
    },

    vim.tbl_map(
      function(i)
        return { "<M-" .. i .. ">", "<CMD>BufferGoto " .. i .. "<CR>" }
      end,
      { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
    ),
  },

  {
    group = "Windows",
    icon = {
      icon = "󰖯",
      color = "red",
    },
    { "<M-w>", "<C-w>", noremap = true },
  },
}

return M
