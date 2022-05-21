local M = {}

function M.setup()
  local installer_ok, installer = pcall(require, "nvm-lsp-installer")
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

  config.sumneko_lua.setup {}
  config.cmake.setup {}

end

return M

