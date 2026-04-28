return{
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      { "<C-j>", mode = { "n", "x", "o" }, function ()
        require("flash").jump({
          search = { mode = "search", max_length = 0, forward = true, wrap = false, multi_window = false },
          label = { after = { 0, 0 } },
          pattern = "^\\s*\\S\\?\\zs",
          jump = { pos = "end" },
        })
      end, desc = "Flash Search forward"},
      { "<C-k>", mode = { "n", "x", "o" }, function ()
        require("flash").jump({
          search = { mode = "search", max_length = 0, forward = false, wrap = false, multi_window = false },
          label = { after = { 0, 0 } },
          pattern = "^\\s*\\S\\?\\zs",
          jump = { pos = "begin" },
        })
      end, desc = "Flash Search backward"},
    },
    config = function ()
      require('flash').setup({
        modes = {
          char = {
            enabled = false,
          }
        }
      })
    end
  }
}
