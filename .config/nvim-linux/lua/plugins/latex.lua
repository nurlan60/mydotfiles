return {
  {
    "conform.nvim",
    formatters_by_ft = {
      tex = { "latexindent" },
    },
  },

  {
    "lervag/vimtex",
    opts = function()
      vim.g["vimtex_view_method"] = "sioyek"
      vim.g["vimtex_mappings_enabled"] = 1
      vim.g["vimtex_indent_enabled"] = 1
      vim.g["vimtex_syntax_enabled"] = 0
      vim.g["vimtex_quickfix_open_on_warning"] = 0
      vim.g["vimtex_quickfix_ignore_filters"] = {
        "Underfull \\hbox",
        "Overfull \\hbox",
        "LaTeX Warning: Unused global option(s):",
      }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          keys = {
            { "<leader>tb", "<cmd>TexlabBuild<CR>", desc = "Compile LaTeX" },
            { "<leader>tv", "<cmd>TexlabForward<CR>", desc = "Forward View LaTeX" },
          },
        },
      },
      setup = {
        texlab = function(_, opts)
          opts.settings = {
            texlab = {
              forwardSearch = {
                executable = "zathura",
                args = {
                  "--synctex-forward",
                  "%l:1:%f",
                  "%p",
                },
              },
            },
          }
        end,
      },
    },
  },
}
