local M = {}

function M.setup()
  local status_ok, neogit = pcall(require, "neogit")
  if not status_ok then
    return
  end

  neogit.setup {
    disable_commit_confirmation = true,
    disable_insert_on_commit = false,
    integrations = {
      diffview = true,
    },
  }
end

return M
