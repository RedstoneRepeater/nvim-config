return{
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
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
  }
}
