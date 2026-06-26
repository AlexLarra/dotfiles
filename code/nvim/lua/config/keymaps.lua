-- ============================================================
-- => CHEATSHEET (Leader = <Space>)
-- ============================================================
--   General
--     <Space>w          sudo save (:W)
--     <C-y> (v)         yank to clipboard
--     <C-s>             save
--     jj (i)            exit insert mode
--     ^                 clear search highlight
--
--   Buffers & Tabs
--     <Space>h/l        prev/next buffer
--     <Space>ba         close all buffers
--     <Space>to         tab only
--     <Space>tc         close tab
--     <Space>tm         move tab
--     <Space>n          :Texplore (file explorer)
--     <M-h/j/k/l>       prev/next tab
--
--   Splits & Panes
--     <Space>-          horizontal split
--     <Space>+          vertical split
--     S-h/j/k/l         move between splits
--
--   Fzf
--     <Space>f          fuzzy file -> tabedit
--     <Space>F          fuzzy file -> edit
--
--   Search & Replace
--     <Space>d          replace word under cursor
--     <Space>sa         select all
--     <Space>sl         select line
--     <Space>a          Ack search
--     <Space>A          Ack word under cursor
--
--   Rails / Quickfix
--     <Space>q          load quickfix.out
--     <Space>m          open last migration
--     <Space>g          changed files vs master
--
--   Git
--     <Space>gn/gp      next/prev hunk
--     <Space>ga         stage hunk
--     <Space>gu         undo hunk
--     <Space>gl         open line in GitHub
--     <Space>gb         blame line in GitHub
--     <Space>go         open repo in GitHub
--
--   RSpec -> Tmux (non-blocking)
--     <Space>rf          current spec file
--     <Space>rt          nearest spec (line)
--     <Space>rl          last spec
--     <Space>ra          all specs
--
--   Opencode -> Tmux
--     <Space>o           free prompt (file + line)
--     <Space>oe          explain (file+line / visual)
--     <Space>or          refactor (file+line / visual)
--     <Space>ot          generate test (file+line / visual)
--
--   Tmux <-> Vim
--     <Space>e           jump to last Rails error
--     <Space>tt          toggle implementation <-> test
--
--   Motion
--     <M-d/u>           move line(s) down/up
--
--   Other
--     <Space>cd         cd to current buffer directory
--
-- ============================================================

local keymap = vim.keymap.set
local g = vim.g

g.mapleader = " "

-- Save
keymap("n", "<C-s>", ":w<CR>")
keymap("v", "<C-s>", "<Esc><C-s>gv")
keymap("i", "<C-s>", "<Esc><C-s>")

-- Exit insert
keymap("i", "jj", "<Esc>")

-- Clear search
keymap("n", "^", ":noh<CR>", { silent = true })

-- Buffers
keymap("n", "<leader>l", ":bnext<CR>")
keymap("n", "<leader>h", ":bprevious<CR>")
keymap("n", "<leader>ba", ":bufdo bd<CR>")

-- Tabs
keymap("n", "<leader>to", ":tabonly<CR>")
keymap("n", "<leader>tc", ":tabclose<CR>")
keymap("n", "<leader>tm", ":tabmove<CR>")
keymap("n", "<M-h>", "gT")
keymap("n", "<M-j>", "gT")
keymap("n", "<M-l>", "gt")
keymap("n", "<M-k>", "gt")

-- Splits
keymap("n", "<Leader>-", ":split<CR>")
keymap("n", "<Leader>+", ":vs<CR>")
keymap("n", "<S-j>", "<C-w><C-j>")
keymap("n", "<S-k>", "<C-w><C-k>")
keymap("n", "<S-l>", "<C-w><C-l>")
keymap("n", "<S-h>", "<C-w><C-h>")

-- Explorer
keymap("n", "<leader>n", ":Texplore<CR>")

-- CD
keymap("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")

-- Search & Replace
keymap("n", "<Leader>d", ":%s/<C-r><C-w>//gc<Left><Left><Left>")
keymap("n", "<Leader>sa", "ggVG")
keymap("n", "<Leader>sl", "_v$")

-- Yank to clipboard (visual)
keymap("v", "<C-y>", "y :silent call system('wl-copy', @\")<CR>")

-- Sudo save
vim.api.nvim_create_user_command("W", function()
  vim.cmd("w !sudo tee % > /dev/null")
  vim.cmd("edit!")
end, {})

-- Ack
keymap("n", "<Leader>a", ":Ack \"\"<Left>")
keymap("n", "<Leader>A", ":Ack <C-r><C-w><CR>")

-- Quickfix
keymap("n", "<leader>q", ":cg quickfix.out | cwindow<CR>")

-- Move lines
keymap("n", "<M-d>", "mz:m+<cr>`z")
keymap("n", "<M-u>", "mz:m-2<cr>`z")
keymap("v", "<M-d>", ":m'>+<cr>`<my`>mzgv`yo`z")
keymap("v", "<M-u>", ":m'<-2<cr>`>my`<mzgv`yo`z")

-- Custom functions
local funcs = require("config.functions")

keymap("n", "<leader>m", funcs.open_last_migration)
keymap("n", "<leader>g", funcs.open_changed_files)
keymap("n", "<leader>o", funcs.tmux_opencode, { silent = true })

keymap("n", "<leader>rf", function() funcs.tmux_rspec(vim.fn.expand("%:p")) end, { silent = true })
keymap("n", "<leader>rt", function() funcs.tmux_rspec(vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")) end, { silent = true })
keymap("n", "<leader>rl", function() funcs.tmux_rspec(vim.g.last_rspec_spec or "") end, { silent = true })
keymap("n", "<leader>ra", function() funcs.tmux_rspec("") end, { silent = true })

keymap("n", "<leader>oe", function() funcs.opencode_mode("explain", "") end, { silent = true })
keymap("n", "<leader>or", function() funcs.opencode_mode("refactor", "") end, { silent = true })
keymap("n", "<leader>ot", function() funcs.opencode_mode("test", "") end, { silent = true })

keymap("v", "<leader>oe", function()
  vim.cmd('normal! "zy')
  funcs.opencode_mode("explain", vim.fn.getreg("z"))
end, { silent = true })
keymap("v", "<leader>or", function()
  vim.cmd('normal! "zy')
  funcs.opencode_mode("refactor", vim.fn.getreg("z"))
end, { silent = true })
keymap("v", "<leader>ot", function()
  vim.cmd('normal! "zy')
  funcs.opencode_mode("test", vim.fn.getreg("z"))
end, { silent = true })

keymap("n", "<leader>e", funcs.tmux_goto_last_error, { silent = true })
keymap("n", "<leader>tt", funcs.open_rails_test, { silent = true })
