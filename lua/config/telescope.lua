local M = {}

function M.setup()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  telescope.setup {
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "build_*",
        "tools/cmake",
      },
      layout_config = {
        vertical = { width = 0.5 }
      },
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key"
        }
      }
    },
    pickers = {
      find_files = {
        theme = "ivy",
      },
      oldfiles = {
        theme = "ivy",
      },
      git_files = {
        theme = "ivy",
      }
    },
    extensions = {
    }
  }

  -- telescope.load_extension("fzf")
  -- telescope.load_extension("ui-select")
end

return M

