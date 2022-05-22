local M = {}

function M.setup()

  local status_ok, lualine = pcall(require, "lualine")

  if not status_ok then
    return
  end

  local custom_gruvbox = require 'lualine.themes.gruvbox'

  -- Change the background of lualine_c section for normal mode
  custom_gruvbox.normal.c.bg = '#112233'

  lualine.setup({
    options = {
      icons_enabled = false,
      theme = custom_gruvbox,
      section_separators = '',
      component_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { '%f' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { '%f' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  })
end

return M
