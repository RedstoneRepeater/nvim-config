return{
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "codelldb",
      }
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            local default = vim.fn.expand("%:r")
            if vim.fn.filereadable(default) == 0 then
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end
            return default
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },

  {
    "MironPascalCaseFan/debugmaster.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      {"<leader>d", function() require("debugmaster").mode.toggle() end, { nowait = true }},
    },
    config = function()
      local dm = require("debugmaster")
      -- make sure you don't have any other keymaps that starts with "<leader>d" to avoid delay
      -- Alternative keybindings to "<leader>d" could be: "<leader>m", "<leader>;"
      -- If you want to disable debug mode in addition to leader+d using the Escape key:
      -- vim.keymap.set("n", "<Esc>", dm.mode.disable)
      -- This might be unwanted if you already use Esc for ":noh"
    end,
  }
}
