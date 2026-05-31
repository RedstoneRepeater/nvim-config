return{
  {
    'saghen/blink.cmp',
    event = {"InsertEnter", "CmdlineEnter"},
    dependencies = { 'rafamadriz/friendly-snippets', 'saghen/blink.lib' },
    -- version = '*',
    -- build = "cargo build --release",
    build = function()
      -- build the fuzzy matcher, wait up to 60 seconds
      -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
      require('blink.cmp').build():pwait()
    end,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      cmdline = {
        completion = {
          menu = {
            auto_show = false,
          }
        },
        keymap = {
          preset = "none",
          ["<Tab>"] = { "accept", "show" },
          ["<C-p>"] = { "select_prev", "fallback" },
          ["<C-n>"] = { "select_next", "fallback" },
          ['<C-e>'] = { 'cancel', 'fallback' },
        }
      },
      keymap = {
        preset = 'none',

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
      },
      completion = {
        -- 示例：使用'prefix'对于'foo_|_bar'单词将匹配'foo_'(光标前面的部分),使用'full'将匹配'foo__bar'(整个单词)
        keyword = { range = 'prefix' },
        -- 选择补全项目时显示文档(0.4秒延迟)
        documentation = { auto_show = true, auto_show_delay_ms = 400 },
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
          snippets = { score_offset = 3 },
        }
      },

      fuzzy = { implementation = "rust" }
    },

    opts_extend = { "sources.default" }
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    -- dependencies = { "saghen/blink.cmp" }, -- 确保与 blink.cmp 兼容
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
      -- autopairs.get_rule("{"):with_cr(function()
      --   return true -- 按回车时自动换行并缩进
      -- end)
      accept = { auto_brackets = { enabled = true } }

    end,
  }
}
