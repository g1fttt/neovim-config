return {
  name = "vue_ls",
  opts = {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json" },
    on_init = function(client)
      client.handlers["tsserver/request"] = function(_, result, context)
        local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
        if #clients == 0 then
          local utils = require("utils")

          utils.report_error({ "Missing vtsls" })

          return
        end

        local param = unpack(result)
        local id, command, payload = unpack(param)

        local ts_client = clients[1]

        ts_client:exec_cmd({
            title = "vue_request_forward",
            command = "typescript.tsserverRequest",
            arguments = {
              command,
              payload,
            },
          },
          { bufnr = context.bufnr },
          function(_, r)
            local response = r and r.body
            local response_data = { { id, response } }

            client:notify("tsserver/response", response_data)
          end)
      end
    end,
    on_attach = function(client)
      client.server_capabilities.semanticTokensProvider.full = true
    end,
  },
}
