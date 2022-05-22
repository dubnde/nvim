local M = {}

function M.setup()
  local installer_ok, installer = pcall(require, "nvim-lsp-installer")
  if not installer_ok then
    return
  end

  local config_ok, config = pcall(require, "lspconfig")
  if not config_ok then
    return
  end

  installer.setup {}

  local keymap = vim.keymap.set

  local fn_on_attach = function ()
    -- local opts = { noremap = true, silent = true, buffer = 0 }
    local opts = { buffer = 0 }

    -- Key mappings
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gi", vim.lsp.buf.implementation, opts)
    keymap("n", "gs", vim.lsp.buf.signature_help, opts)
    keymap("n", "gt", vim.lsp.buf.type_definition, opts)
    keymap("n", "[e", vim.diagnostic.goto_prev, opts)
    keymap("n", "]e", vim.diagnostic.goto_next, opts)

    -- if client.server_capabilities.documentFormattingProvider then
    --   keymap_l.l.F = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format Document" }
    -- end
  end

  config.sumneko_lua.setup {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          -- So 'gf' can find the files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          },
        },
        telemetry = { enable = false },
      }
    },

    on_attach = fn_on_attach,
  }

  config.cmake.setup {}
  config.rust_analyzer.setup {}
  config.pyright.setup {}
  config.clangd.setup {}
  config.jsonls.setup {}

end

return M

