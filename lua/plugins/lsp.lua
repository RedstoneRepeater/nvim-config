return{
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = { "nvimdev/lspsaga.nvim" },
    config = function()
      vim.lsp.config("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })
      vim.lsp.enable("clangd")
      vim.lsp.enable("bashls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("tinymist")
      vim.diagnostic.config{
        virtual_text = true,
      }
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      require("lspsaga").setup({
        lightbulb = {
          sign = false,
        }
      })
      vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true,nowait = true })
      vim.keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.setqflist()<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>E", "<cmd>lua vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })<CR>", { noremap = true, silent = true })
      nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
      nmap('<leader>go', "<cmd>Lspsaga outline<CR>", '[G]o [O]utline')
      nmap('<leader>pd', "<cmd>Lspsaga peek_definition<CR>", '[P]eek [D]efinition')
      nmap('<leader>rn', "<cmd>lua vim.lsp.buf.rename()<cr>", '[R]e[n]ame')
      nmap('<leader>ca', "<cmd>Lspsaga code_action<CR>", '[C]ode [A]ction')
      nmap('<leader>lf', "<cmd>Lspsaga finder<CR>", '[L]sp [F]inder')
      nmap(']e', "<cmd>Lspsaga diagnostic_jump_next<CR>", 'jump [N]ext')
      nmap('[e', "<cmd>Lspsaga diagnostic_jump_prev<CR>", 'jump [P]review')
      vim.keymap.set("n", "[E", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end)
      vim.keymap.set("n", "]E", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end)
    end,
  }
}
