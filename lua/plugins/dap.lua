return{
  {
    "mfussenegger/nvim-dap",
    keys = {
      {"<leader>b", function() require("dap").toggle_breakpoint() end, { silent = true, desc = "Toggle Breakpoint" }},
      {'<leader>db', function()
        local input = vim.fn.input 'Condition for breakpoint:'
        require("dap").set_breakpoint(input)
      end, { desc = 'DAP: Conditional Breakpoint' }}
    },
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

      -- vim.keymap.set("n", "<F5>", function() dap.continue() end, { silent = true, desc = "Continue" })
      vim.keymap.set("n", "<F10>", function() dap.step_over() end, { silent = true, desc = "Step Over" })
      vim.keymap.set("n", "<F11>", function() dap.step_into() end, { silent = true, desc = "Step Into" })
      vim.keymap.set("n", "<F12>", function() dap.step_out() end, { silent = true, desc = "Step Out" })
      vim.keymap.set('n', '<leader>dc', function() dap.run_to_cursor() end, { desc = 'DAP: Run to Cursor' })
      vim.keymap.set('n', '<leader>dq', dap.close, { desc = 'DAP: Close session' })
      vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Terminate session' })
      vim.keymap.set('n', '<leader>dr', function() require("dap").repl.toggle() end, { desc = 'DAP: Toggle REPL' })
      vim.keymap.set('n', '<leader>dw', require('dap.ui.widgets').hover, { desc = 'DAP: Hover' })
      vim.keymap.set('n', '<leader>df', dap.restart_frame, { desc = 'DAP: Restart' })
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {"<leader>du", function() require("dapui").toggle() end, { silent = true, desc = "Toggle DAP UI" }},
      {"<F5>", function() require("dap").continue() end, { silent = true, desc = "Continue" }}
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup({
        layouts = {
          {
            elements = { "scopes", "breakpoints", "watches", "stacks" },
            size = 40,
            position = "left",
          },
          {
            elements = { { id= "console", size = 0.55 }, { id= "repl", size = 0.45 } },
            size = 10,
            position = "bottom",
          },
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  }
}
