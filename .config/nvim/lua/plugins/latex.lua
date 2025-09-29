local os_name = vim.loop.os_uname().sysname
if os_name == "Linux" then
  return {
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
  }
elseif os_name == "Darwin" then -- macOS
  return {
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
                executable = "displayline",
                args = {
                  "%l",
                  "%p",
                  "%f",
                },
              },
            },
          }
        end,
      },
    },
  }
elseif os_name == "Windows" then
  -- Do something for Windows
end
