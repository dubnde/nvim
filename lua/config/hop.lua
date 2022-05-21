local M = {}

local status_ok, hop = pcall(require, "hop")
if status_ok then
  local keymap = vim.api.nvim_set_keymap
  local opts = { noremap = true, silent = true }

  -- visual mode (easymotion-like)
  keymap("n", "<leader><leader>w", "<cmd>HopWordAC<CR>", opts)
  keymap("n", "<leader><leader>W", "<cmd>HopWord<CR>", opts)
  keymap("n", "<leader><leader>b", "<cmd>HopWordBC<CR>", opts)
  keymap("n", "<leader><leader>l", "<cmd>HopLine<CR>", opts)
  keymap("n", "<leader><leader>j", "<cmd>HopLineAC<CR>", opts)
  keymap("n", "<leader><leader>k", "<cmd>HopLineBC<CR>", opts)

  keymap("v", "<leader><leader>w", "<cmd>HopWordAC<CR>", opts)
  keymap("v", "<leader><leader>W", "<cmd>HopWord<CR>", opts)
  keymap("v", "<leader><leader>l", "<cmd>HopLine<CR>", opts)
  keymap("v", "<leader><leader>b", "<cmd>HopWordBC<CR>", opts)
  keymap("v", "<leader><leader>j", "<cmd>HopLineAC<CR>", opts)
  keymap("v", "<leader><leader>k", "<cmd>HopLineBC<CR>", opts)

  -- normal mode (sneak-like)
  keymap("n", "s", "<cmd>HopChar2AC<CR>",opts)
  keymap("n", "S", "<cmd>HopChar2BC<CR>",opts)

  -- visual mode (sneak-like)
  keymap("v", "s", "<cmd>HopChar2AC<CR>",opts)
  keymap("v", "S", "<cmd>HopChar2BC<CR>",opts)
end

function M.setup()
  hop.setup {}
end

return M
