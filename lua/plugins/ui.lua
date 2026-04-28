return{
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "cpp", "c", "lua", "vim", "bash", "java", "vimdoc", "json", "make", "cmake", "python", "xml" },
        highlight = { enable = true },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
          tab_char = "┆", -- tab 字符的显示
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
  }
}
