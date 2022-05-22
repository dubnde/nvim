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

  installer.setup {
    ensure_installed = {
      "rust_analyzer",
      "sumneko_lua",
      "cmake",
      "pyright",
      "clangd",
      "jsonls"
    },
    automatic_installation = true,
  }

  config.sumneko_lua.setup {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          -- So 'gf' can find the files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      }
    }
  }

  config.cmake.setup {}
  config.rust_analyzer.setup {}
  config.pyright.setup {}
  config.clangd.setup {}
  config.jsonls.setup {}

end

return M

