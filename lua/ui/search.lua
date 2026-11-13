local M = {}

local modes = {
  { label = "Files", source = "files" },
  { label = "Text",  source = "grep", live = true },
}

local function title(idx)
  local parts = {}
  for i, m in ipairs(modes) do
    parts[i] = (i == idx and "● " or "○ ") .. m.label
  end
  return table.concat(parts, " ")
end

---@param source? string source name from modes, for example "files" or "grep"
function M.open(source)
  local idx = 1
  for i, m in ipairs(modes) do
    if m.source == source then idx = i end
  end

  Snacks.picker({
    title = title(idx),
    live = modes[idx].live or false,
    supports_live = true,
    finder = function(opts, ctx)
      local src = modes[idx].source
      return require("snacks.picker.source." .. src)[src](opts, ctx)
    end,
    format = "file",
    show_empty = true,
    follow = true,
    regex = true,
    icons = { ui = { live = "" } },
    toggles = { follow = false },
    actions = {
      next_mode = function(picker)
        idx = idx % #modes + 1
        local text = picker.input:get()
        local live = modes[idx].live or false
        picker.opts.live = live
        picker.title = title(idx)
        picker.input:set(live and "" or text, live and text or "")
        picker:find()
      end,
    },
    win = {
      input = {
        keys = {
          ["<Tab>"] = { "next_mode", mode = { "i", "n" } },
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        }
      }
    }
  })
end

return M
