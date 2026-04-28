return{
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    cmd = "Oil",
    opts = {},
    -- Optional dependencies
    -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    -- lazy = false,
    vim.keymap.set("n", "<C-n>", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
  },

  -- {
  --   'nvim-telescope/telescope.nvim', version = '*',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     -- optional but recommended
  --     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --   },
  --   builtin = require('telescope.builtin'),
  --   keys = {
  --     {'<leader>ff', builtin.find_files, { desc = 'Telescope find files' }},
  --     {'<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' }},
  --     {'<leader>fb', builtin.buffers, { desc = 'Telescope buffers' }},
  --     {'<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }},
  --   }
  -- }
}
