return {
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme sonokai")
    end,
  },
  {
    "ruanyl/vim-gh-line",
    init = function()
      vim.g.gh_line_map = "<leader>gl"
      vim.g.gh_line_blame_map = "<leader>gb"
      vim.g.gh_repo_map = "<leader>go"
    end,
  },

  {
    "mattn/emmet-vim",
    init = function()
      vim.g.user_emmet_leader_key = ","
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = ">" },
          delete = { text = "-" },
          topdelete = { text = "^" },
          changedelete = { text = "<" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          vim.keymap.set("n", "<leader>gn", gs.next_hunk, { buffer = bufnr })
          vim.keymap.set("n", "<leader>gp", gs.prev_hunk, { buffer = bufnr })
          vim.keymap.set("n", "<leader>ga", gs.stage_hunk, { buffer = bufnr })
          vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = bufnr })
        end,
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  { "tpope/vim-commentary" },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        actions = {
          files = {
            ["default"] = fzf.actions.file_tabedit,
          },
        },
        files = {
          cmd = vim.env.FZF_DEFAULT_COMMAND,
        },
      })

      -- Fuzzy file -> tabedit (default action)
      vim.keymap.set("n", "<Leader>f", fzf.files)

      -- Fuzzy file -> edit
      vim.keymap.set("n", "<Leader>F", function()
        fzf.files({ actions = { ["default"] = fzf.actions.file_edit } })
      end)
    end,
  },

}
