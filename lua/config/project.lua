local M = {}

function M.setup()
  local status_ok, project = pcall(require, "neogit")
  if not status_ok then
    return
  end

  -- vim.g.nvim_tree_respect_buf_cwd = 1

  project.setup {

    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
    -- order matters: if one is not detected, the other is used as fallback. You
    -- can also delete or rearangne the detection methods.
    detection_methods = { "lsp", "pattern" },

    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- detection_methods
    patterns = {
      ".git",
      ".project",
      ".vscode",
      "compile_commands.json",
      "package.json",
      "setup_pw.sh",
      "Cargo.toml",
      "_darcs",
      ".hg",
      ".bzr",
      ".svn",
      "Makefile",
    },
  }
end

return M

