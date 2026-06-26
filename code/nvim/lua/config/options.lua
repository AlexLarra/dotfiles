local opt = vim.opt
local g = vim.g

vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

opt.history = 500
opt.path:append("**")
opt.autoread = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.backspace = { "eol", "start", "indent" }
opt.whichwrap:append("<,>,h,l")
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.lazyredraw = true
opt.magic = true
opt.showmatch = true
opt.mat = 2
opt.errorbells = false
opt.visualbell = false
opt.tm = 500
opt.foldcolumn = "1"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileformats = "unix"
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.linebreak = true
opt.textwidth = 500
opt.autoindent = true
opt.smartindent = true
opt.wrap = true
opt.laststatus = 2
opt.cmdheight = 1
opt.ruler = true
opt.scrolloff = 7
opt.hidden = true
opt.switchbuf = "useopen,usetab,newtab"
opt.showtabline = 2
opt.updatetime = 300

-- Hack for gnome-terminal Alt problem
local c = string.byte("a")
while c <= string.byte("z") do
  local char = string.char(c)
  vim.cmd(string.format("set <A-%s>=\\e%s", char, char))
  vim.cmd(string.format("imap \\e%s <A-%s>", char, char))
  c = c + 1
end
opt.timeout = true
opt.ttimeoutlen = 50

-- Netrw
g.netrw_banner = 0

-- Emmet
g.user_emmet_leader_key = ","

-- FZF default command
vim.env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow " ..
  "--exclude '*.o' " ..
  "--exclude '*~' " ..
  "--exclude '*.pyc' " ..
  "--exclude '*.rbc' " ..
  "--exclude '.git' " ..
  "--exclude '.hg' " ..
  "--exclude '.svn' " ..
  "--exclude '.DS_Store' " ..
  "--exclude '.byebug_history' " ..
  "--exclude 'tmp' " ..
  "--exclude 'log' " ..
  "--exclude 'vendor' " ..
  "--exclude 'public/assets' " ..
  "--exclude 'storage' " ..
  "--exclude 'node_modules' " ..
  "--exclude 'db/migrate' " ..
  "--exclude 'bin' " ..
  "--exclude 'spec/fixtures' " ..
  "--exclude 'test/fixtures' " ..
  "--exclude 'coverage' " ..
  "--exclude '.bundle' " ..
  "--exclude 'sprockets'"

-- Tabline (keep original VimScript function)
vim.cmd([[
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')
    if tabnr > 1
      let s .= '%#TabLine#|'
    endif
    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '* ' | endif
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!MyTabLine()
]])

-- Autocmds
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  pattern = "*",
  command = "checktime",
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
