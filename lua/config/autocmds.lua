local line_numbers_group = vim.api.nvim_create_augroup("toggle_line_numbers", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  group = line_numbers_group,
  desc = "Toggle relative line numbers on",
  callback = function()
    if vim.wo.nu and not vim.startswith(vim.api.nvim_get_mode().mode, "i") then vim.wo.relativenumber = true end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  group = line_numbers_group,
  desc = "Toggle relative line numbers off",
  callback = function(args)
    if vim.wo.nu then vim.wo.relativenumber = false end

    -- Redraw here to avoid having to first write something for the line numbers to update.
    if args.event == "CmdlineEnter" then
      if vim.fn.getcmdtype() == ":" and not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then vim.cmd.redraw() end
    end
  end,
})

local cursorline_group = vim.api.nvim_create_augroup("toggle_cursorline", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "WinEnter" }, {
  group = cursorline_group,
  desc = "Toggle relative line numbers on",
  callback = function()
    if not vim.wo.cul then vim.wo.cursorline = true end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "WinLeave" }, {
  group = cursorline_group,
  desc = "Toggle relative line numbers off",
  callback = function()
    if vim.wo.cul then vim.wo.cursorline = false end
  end,
})

local hlsearch_group = vim.api.nvim_create_augroup("toggle_hlsearch", {})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = hlsearch_group,
  desc = "Toggle relative line numbers on",
  callback = function()
    if not vim.o.hls then vim.o.hlsearch = true end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  group = hlsearch_group,
  desc = "Toggle relative line numbers off",
  callback = function()
    if vim.o.hls then vim.o.hlsearch = false end
  end,
})
