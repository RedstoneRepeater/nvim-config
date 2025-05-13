-- ~/.config/nvim/init.lua

-- /搜索时忽略大小写
vim.o.ignorecase = true
-- /搜索时智能大小写
vim.o.smartcase = true
-- 高亮当前行
vim.o.cursorline = true
-- 设置 leader 键
vim.g.mapleader = " "
vim.g.maplocalleadher = " "
--相对行号
vim.o.relativenumber = true

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- $跳到行尾不带空格
vim.keymap.set({ "v", "n" }, "$", "g_")
vim.keymap.set({ "v", "n" }, "g_", "$")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set({'n','t'}, '<A-d>', '<cmd>Lspsaga term_toggle<CR>')
vim.keymap.set("n", "<leader><CR>", "<CMD>noh<CR>", { desc = "Clear Highlights" })
vim.keymap.set("i", "<esc>", "<esc><CMD>noh<CR>", { desc = "Clear Highlights" })
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", { desc = "Move Text Down" })
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", { desc = "Move Text Up" })
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Close Terminal" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h",{desc = "Move window"})
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j",{desc = "Move window"})
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k",{desc = "Move window"})
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l",{desc = "Move window"})
vim.keymap.set("n", "<C-h>", "<C-w>h",{desc = "Move window"})
vim.keymap.set("n", "<C-j>", "<C-w>j",{desc = "Move window"})
vim.keymap.set("n", "<C-k>", "<C-w>k",{desc = "Move window"})
vim.keymap.set("n", "<C-l>", "<C-w>l",{desc = "Move window"})
--vim.keymap.set({"n","v"},"<C-j>", "5j", { noremap = true, silent = true })
--vim.keymap.set({"n","v"},"<C-k>", "5k", { noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Right>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "i", "v" }, "<Down>", "<Nop>")
vim.o.mouse = ""

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>cl", '<cmd>cclose<CR>')
vim.keymap.set("n", "<leader>co", '<cmd>copen<CR>')

vim.keymap.set("n", "]b", "<cmd>bnext<CR>")
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>")
vim.keymap.set("n", "]B", "<cmd>blast<CR>")
vim.keymap.set("n", "[B", "<cmd>bfirst<CR>")
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")
vim.keymap.set("n", "]Q", "<cmd>clast<CR>")
vim.keymap.set("n", "[Q", "<cmd>cfirst<CR>")
vim.keymap.set("n", "]<C-q>", "<cmd>cnfile<CR>")
vim.keymap.set("n", "[<C-q>", "<cmd>cpfile<CR>")
vim.keymap.set("n", "]a", "<cmd>next<CR>")
vim.keymap.set("n", "[a", "<cmd>previous<CR>")
vim.keymap.set("n", "]A", "<cmd>last<CR>")
vim.keymap.set("n", "[A", "<cmd>first<CR>")
vim.keymap.set("n", "]l", "<cmd>lnext<CR>")
vim.keymap.set("n", "[l", "<cmd>lprevious<CR>")
vim.keymap.set("n", "]L", "<cmd>llast<CR>")
vim.keymap.set("n", "[L", "<cmd>lfirst<CR>")
vim.keymap.set("n", "]<C-l>", "<cmd>lnfile<CR>")
vim.keymap.set("n", "[<C-l>", "<cmd>lpfile<CR>")
-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/site/pack/lazy/start/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 插件
require("lazy").setup({
  -- 1. nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "cpp", "c", "lua", "vim", "bash", "java", "vimdoc", "json" },
        highlight = { enable = true },
      })
    end,
  },

  -- 2. LSP :nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    ft = { "cpp", "c", "lua", "bash", "sh" },
    rependencies = { "saghen/blink.cmp" },
    dependencies = { "nvimdev/lspsaga.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern("compile_commands.json", ".clangd", ".git"),
      })
      lspconfig.bashls.setup({
        capabilities = require("blink-cmp").get_lsp_capabilities(),
        filetypes = { "bash", "sh" },
      })
      lspconfig.lua_ls.setup({
        capabilities = require("blink-cmp").get_lsp_capabilities(),
        filetypes = { "lua" },
      })
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      require("lspsaga").setup()
      vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true,nowait = true })
      vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.diagnostic.setqflist()<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })<CR>", { noremap = true, silent = true })
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
  },

  -- 3. blink-cmp
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    -- version = '*',
    build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          }
        },
        keymap = {
          preset = "none",
          ["<Tab>"] = {"accept"},
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
        }
      },
      keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        -- ['<C-e>'] = { 'hide' },
        -- fallback命令将运行下一个非闪烁键盘映射(回车键的默认换行等操作需要)
        ['<C-e>'] = { 'hide' },
        ['<CR>'] = { 'accept', 'fallback' }, -- 更改成'select_and_accept'会选择第一项插入
        ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback' }, -- 同时存在补全列表和snippet时，补全列表选择优先级更高

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' }, -- 同时存在补全列表和snippet时，snippet跳转优先级更高
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

      },
      completion = {
        -- 示例：使用'prefix'对于'foo_|_bar'单词将匹配'foo_'(光标前面的部分),使用'full'将匹配'foo__bar'(整个单词)
        keyword = { range = 'full' },
        -- 选择补全项目时显示文档(0.5秒延迟)
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        -- 不预选第一个项目，选中后自动插入该项目文本
        list = { selection = { preselect = false, auto_insert = true } },
      },
      -- 指定文件类型启用/禁用
      enabled = function()
        return not vim.tbl_contains({
          -- "lua",
          -- "markdown"
        }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
      end,

      appearance = {
        -- 将“Nerd Font Mono”设置为“mono”，将“Nerd Font”设置为“normal”
        -- 调整间距以确保图标对齐
        nerd_font_variant = 'mono'
      },

      -- 已定义启用的提供程序的默认列表，以便您可以扩展它
      sources = {
        default = { 'buffer', 'lsp', 'path', 'snippets', },
        providers = {
          -- score_offset设置优先级数字越大优先级越高
          buffer = { score_offset = 4 },
          path = { score_offset = 3 },
          lsp = { score_offset = 4 },
          snippets = { score_offset = 1 },
        }
      },
    },
    -- 由于“opts_extend”，您的配置中的其他位置无需重新定义它
    opts_extend = { "sources.default" }
  },

  -- 4. 文件浏览器：nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { "<C-n>" },
    config = function()
      require("nvim-tree").setup()
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -- 5. 状态栏：lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
      })
    end,
  },

  -- 6.nightfox
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    lazy = false,
    config = function ()
      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic",
            keywords = "bold",
          }
        }
      })
      vim.cmd("colorscheme nightfox")
    end,
  },

  -- 7. 异步运行：asyncrun.vim
  {
    "skywind3000/asyncrun.vim",
    event = 'VeryLazy',
    config = function()
      vim.g.asyncrun_open = 7 -- 自动打开 Quickfix，高度 7 行
      vim.keymap.set("n", "<leader>rt", ":AsyncRun -mode=term -pos=hide g++ % -o %:r<CR>", { desc = "Compile (Terminal)" })
      vim.keymap.set("n", "<F7>", ":w<CR>:AsyncRun g++ % -o %:r -g<CR>", { desc = "Compile with Debug" })
      vim.keymap.set("n", "<leader>cs", ":AsyncStop<CR>", { silent = true, desc = "Stop AsyncRun" })
      vim.keymap.set("n", "<leader>cc", ":AsyncRun g++ % -o %:r && ./%:r<CR>", { silent = true, desc = "Compile and Run C++" })
    end,
  },

  -- 8. 模糊搜索：telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
        .. "cmake --build build --config Release && "
        .. "cmake --install build --prefix build",
      },
    },
    keys = {
      { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fr", ":Telescope registers<CR>", desc = "Find Registers" },
      { "<leader>fg", ":Telescope live_grep<CR>", desc = "Live Grep" },
      { "<leader>fb", ":Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fq", ":Telescope quickfix<CR>", desc = "Quickfix" },
      { "<leader>hq", ":Telescope quickfixhistory<CR>", desc = "Quickfix" },
      { "<leader>cr", function()
        require("telescope.builtin").find_files({
          prompt_title = "Compile and Run C++ File",
          attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
              local selection = require("telescope.actions.state").get_selected_entry()
              require("telescope.actions").close(prompt_bufnr)
              local cmd = string.format("g++ %s -o %s && ./%s",
              selection.path,
              vim.fn.fnamemodify(selection.path, ":r"),
              vim.fn.fnamemodify(selection.path, ":r"))
              vim.cmd("AsyncRun " .. cmd)
            end)
            return true
          end,
        })
      end, desc = "Compile and Run C++" },
    },
    config = function()
      local actions = require "telescope.actions"
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { height = 0.9, width = 0.8 },
          mappings = {
            i = {
              ["<C-c>"] = actions.close,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
    end,
  },

  -- 9. nvim-dap
  {
    "mfussenegger/nvim-dap",
    -- dependencies = {
      --   -- Installs the debug adapters for you
      --   'williamboman/mason.nvim',
      --   'jay-babu/mason-nvim-dap.nvim',
      -- },
      ft = { "cpp", "c" },
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

        vim.keymap.set("n", "<F5>", function() dap.continue() end, { silent = true, desc = "Continue" })
        vim.keymap.set("n", "<F10>", function() dap.step_over() end, { silent = true, desc = "Step Over" })
        vim.keymap.set("n", "<F11>", function() dap.step_into() end, { silent = true, desc = "Step Into" })
        vim.keymap.set("n", "<F12>", function() dap.step_out() end, { silent = true, desc = "Step Out" })
        vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { silent = true, desc = "Toggle Breakpoint" })
        vim.keymap.set('n', '<leader>dc', function() dap.run_to_cursor() end, { desc = 'DAP: Run to Cursor' })
        vim.keymap.set('n', '<leader>dq', dap.close, { desc = 'DAP: Close session' })
        vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Terminate session' })
        vim.keymap.set('n', '<leader>dr', function() require("dap").repl.toggle() end, { desc = 'DAP: Toggle REPL' })
        vim.keymap.set('n', '<leader>dw', require('dap.ui.widgets').hover, { desc = 'DAP: Hover' })
        vim.keymap.set('n', '<leader>df', dap.restart_frame, { desc = 'DAP: Restart' })
        vim.keymap.set('n', '<leader>db', function()
          local input = vim.fn.input 'Condition for breakpoint:'
          dap.set_breakpoint(input)
        end, { desc = 'DAP: Conditional Breakpoint' })
      end,
    },

    -- 10. nvim-dap-ui
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      ft = { "cpp", "c" },
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
        vim.keymap.set("n", "<leader>du", dapui.toggle, { silent = true, desc = "Toggle DAP UI" })

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
    },

    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        local hooks = require "ibl.hooks"
        local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        }
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)
        require("ibl").setup({
          indent = {
            char = "│", -- 缩进线的字符，可以自定义，如 "┆" 或 "▏"
            tab_char = "│", -- tab 字符的显示
            highlight = highlight,
          },
          scope = {
            enabled = true, -- 启用作用域显示
            --show_start = false, -- 不显示作用域开始位置
            --show_end = false, -- 不显示作用域结束位置
          },
          exclude = {
            filetypes = { "help", "terminal", "dashboard", "qf" }, -- 排除某些文件类型
          },
        })
      end,
    },

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      dependencies = { "saghen/blink.cmp" }, -- 确保与 blink.cmp 兼容
      config = function()
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")

        -- 基本设置
        autopairs.setup {
          check_ts = true, -- 启用 Treesitter 检查，提升语言感知
          ts_config = {
            lua = { "string", "source" }, -- 在 Lua 的字符串和源代码中启用
            cpp = { "source" }, -- 在 C++ 源代码中启用
          },
          disable_filetype = { "TelescopePrompt", "vim" }, -- 在这些文件类型中禁用
          fast_wrap = {
            map = "<M-e>", -- Alt+e 触发快速包裹
            chars = { "{", "[", "(", "\"", "'" }, -- 可包裹的符号
            pattern = [=[[%'%"%>%]%)%}%,]]=], -- 触发包裹的结束字符
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl", -- 选择包裹符号的快捷键
          },
        }
        autopairs.get_rule("{"):with_cr(function()
          return true -- 按回车时自动换行并缩进
        end)
        accept = { auto_brackets = { enabled = true } },

        -- 与 blink.cmp 集成
        require("blink-cmp").setup({
          keymap = {
            ["<CR>"] = {
              function(cmp)
                return cmp.accept({
                  callback = cmp_autopairs.on_confirm_done
                })
              end
            }
          }
        })
      end,
    },
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
    },
    {
      'kevinhwang91/nvim-bqf',
      ft = 'qf', -- 只在 Quickfix 窗口加载
      dependencies = {
        { "junegunn/fzf", build = "./install --bin" }
      },
      opts = {
        auto_enable = true, -- 自动启用
        auto_resize_height = true,
        preview = {
          auto_preview = false, -- 自动预览
          -- win_height = 12, -- 预览窗口高度
          -- win_vheight = 11, -- 垂直预览高度
          should_preview_cb = function(bufnr)
            -- file size greater than 100kb can't be previewed automatically
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(filename)
            if fsize > 100 * 1024 then
              return false
            end
            return true
          end,
        },
        func_map = {
          open = '<CR>', -- 回车打开条目
          openc = 'o', -- 'o' 打开并关闭 Quickfix
          tab = 't', -- 在新标签页打开
          vsplit = '<C-v>', -- 垂直拆分打开
          split = '<C-x>', -- 水平拆分打开
        },
      },
    },
  }, {
    performance = {
      rtp = { reset = true },
    },
  })

  -- 全局设置
  vim.opt.number = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
