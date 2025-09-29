return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["tex"] = { "tex-fmt" },
      },
    },
  },

  {
    "lervag/vimtex",
    opts = function()
      vim.g["vimtex_view_method"] = "sioyek"
      vim.g["vimtex_quickfix_open_on_warning"] = 0
      vim.g["vimtex_quickfix_ignore_filters"] = {
        "Underfull \\hbox",
        "Overfull \\hbox",
        "LaTeX Warning: Unused global option(s):",
      }
    end,
  },
}
