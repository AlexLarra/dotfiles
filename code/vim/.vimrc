" https://github.com/amix/vimrc
set history=500
" https://www.youtube.com/watch?v=XA2WjJbmmoM
set path+=**

" Set to auto read when a file is changed from the outside
set autoread
au CursorHold,CursorHoldI * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

" ============================================================
" => CHEATSHEET (Leader = <Space>)
" ============================================================
"   General
"     <Space>w          sudo save
"     <C-y> (v)         yank to clipboard
"     <C-s>             save
"     jj (i)            exit insert mode
"     ^                 clear search highlight
"
"   Buffers & Tabs
"     <Space>h/l        prev/next buffer
"     <Space>ba         close all buffers
"     <Space>to         tab only
"     <Space>tc         close tab
"     <Space>tm         move tab
"     <Space>n          :Texplore (file explorer)
"
"   Splits & Panes (Vim)
"     <Space>-          horizontal split
"     <Space>+          vertical split
"     S-h/j/k/l         move between splits
"     <M-h/j/k/l>       prev/next tab
"
"   Fzf
"     <Space>f          fuzzy file → tabedit
"     <Space>F          fuzzy file → edit
"
"   Search & Replace
"     <Space>d          replace word under cursor
"     <Space>sa         select all
"     <Space>sl         select line
"
"   Rails / Quickfix
"     <Space>q          load quickfix.out
"     <Space>m          open last migration
"     <Space>g          changed files vs master
"
"   Git
"     <Space>gn/gp      next/prev hunk
"     <Space>ga         stage hunk
"     <Space>gu         undo hunk
"
"   RSpec → Tmux (non-blocking)
"     <Space>rf          current spec file
"     <Space>rt          nearest spec (line)
"     <Space>rl          last spec
"     <Space>ra          all specs
"
"   Opencode → Tmux
"     <Space>o           free prompt (file + line)
"     <Space>oe          explain (file+line / visual)
"     <Space>or          refactor (file+line / visual)
"     <Space>ot          generate test (file+line / visual)
"
"   Tmux ↔ Vim
"     <Space>e           jump to last Rails error
"     <Space>tt          toggle implementation ↔ test
"
"   Motion
"     <M-d/u>           move line(s) down/up
"
" ============================================================

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

set relativenumber
set number

" Be able to use mouse to move pointer and select text
set mouse=a

" Copy to clipboard using wl-copy (no gvim needed)
vmap <C-y> y :silent call system('wl-copy', @")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

try
    colorscheme sonokai
catch
    colorscheme desert
endtry

set ffs=unix
set encoding=utf-8
set fileencoding=utf-8


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when Shift + `-`
map <silent> ^ :noh<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>

imap jj <Esc>
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>n :Texplore<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Move through tabs
nmap <M-h> gT
nmap <M-j> gT
nmap <M-l> gt
nmap <M-k> gt

" Add panes
map <Leader>- :split<cr>
map <Leader>+ :vs<cr>

" Move through panes
nmap <S-j> <C-w><C-j>
nmap <S-k> <C-w><C-k>
nmap <S-l> <C-w><C-l>
nmap <S-h> <C-w><C-h>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Open a new tab and search for something
nmap <Leader>a :Ack ""<Left>
" Inmediately search for the word under the cursor in a new tab
nmap <Leader>A :Ack <C-r><C-w><CR>

let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow ' .
            \ '--exclude "*.o" ' .
            \ '--exclude "*~" ' .
            \ '--exclude "*.pyc" ' .
            \ '--exclude "*.rbc" ' .
            \ '--exclude ".git" ' .
            \ '--exclude ".hg" ' .
            \ '--exclude ".svn" ' .
            \ '--exclude ".DS_Store" ' .
            \ '--exclude ".byebug_history" ' .
            \ '--exclude "tmp" ' .
            \ '--exclude "log" ' .
            \ '--exclude "vendor" ' .
            \ '--exclude "public/assets" ' .
            \ '--exclude "storage" ' .
            \ '--exclude "node_modules" ' .
            \ '--exclude "db/migrate" ' .
            \ '--exclude "bin" ' .
            \ '--exclude "spec/fixtures" ' .
            \ '--exclude "test/fixtures" ' .
            \ '--exclude "coverage" ' .
            \ '--exclude ".bundle" ' .
            \ '--exclude "sprockets"'

nmap <Leader>f :call fzf#run(fzf#wrap({'source': $FZF_DEFAULT_COMMAND, 'sink': 'tabedit'}))<CR>
nmap <Leader>F :call fzf#run(fzf#wrap({'source': $FZF_DEFAULT_COMMAND, 'sink': 'e'}))<CR>

nmap <Leader>d :%s/<C-r><C-w>//gc<Left><Left><Left>

map <Leader>sa ggVG
map <Leader>sl _v$

let g:rspec_command = "!bundle exec rspec --format progress --require ~/workspace/dotfiles/code/rspec/quickfix_formatter.rb --format QuickfixFormatter --out quickfix.out {spec}"
map <leader>q :cg quickfix.out \| cwindow<CR>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

set statusline=
set statusline+=%#LineNr#
set statusline+=%#CursorColumn#
set statusline+=\ %f
set statusline+=%m
set statusline+=%=
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=%{'\ '}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tab line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')

    " Add separator '|' at beginning, except in first tab
    if tabnr > 1
      let s .= '%#TabLine#|'
    endif

    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')

    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '

    " Mark if buffer is modified
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '* ' | endif
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction

set tabline=%!MyTabLine()




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[du]
nmap <M-d> mz:m+<cr>`z
nmap <M-u> mz:m-2<cr>`z
vmap <M-d> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-u> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save
autocmd BufWritePre * :%s/\s\+$//e

" NETRW
" https://gist.github.com/danidiaz/37a69305e2ed3319bfff9631175c5d0f
let g:netrw_banner = 0

" HACK for gnome-terminal Alt problem
" https://stackoverflow.com/a/10216459/2988753

let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50

" Define the function to open the last modified file in /db/migrate/
function! OpenLastMigration()
  " Get the last modified file in the /db/migrate/ directory
  let l:latest_migration = system('ls -t db/migrate/*.rb | head -n 1')

  " Remove the newline character at the end of the file path
  let l:latest_migration = substitute(l:latest_migration, '\n', '', 'g')

  " Open the file if it exists
  if !empty(l:latest_migration)
    execute 'tabedit ' . l:latest_migration
  else
    echo "No migration files found."
  endif
endfunction

" Map the <leader>m key combination to call the function
nmap <leader>m :call OpenLastMigration()<CR>

function! OpenChangedFiles()
  " Comprueba la rama actual
  let l:current_branch = system("git rev-parse --abbrev-ref HEAD")
  let l:current_branch = substitute(l:current_branch, '\n', '', 'g')

  " Si estás en la rama master, no hacer nada
  if l:current_branch == "master"
    echo "Already on master branch."
    return
  endif

  " Obtén los archivos cambiados respecto a la rama master
  let l:changed_files = systemlist("git diff --name-only master")

  " Si no hay archivos cambiados, muestra un mensaje y termina
  if empty(l:changed_files)
    echo "No changes compared to master."
    return
  endif

  " Usa el comando de selección en Vim para elegir qué archivo abrir
  call fzf#run(fzf#wrap({'source': l:changed_files, 'sink': 'tabedit'}))
endfunction

" Show files changed comparing to master
nmap <leader>g :call OpenChangedFiles()<CR>

" Open a new tmux pane with opencode for the current file and line
function! TmuxOpencode()
  " Compute relative file path to git root (or use full path)
  let full_path = expand('%:p')
  let root_dir = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '\n\+$', '', '')
  if !empty(root_dir)
    let rel_path = substitute(full_path, '^'.escape(root_dir, '\').'/', '', '')
  else
    let rel_path = full_path
  endif
  " Open a tmux split, type the command with prompt in quotes,
  " and place cursor before the closing quote for user input
  let ln = line('.')
  let cmd = "opencode --prompt \"En el contexto de la línea " . ln . " del archivo " . rel_path . " \""
  let shell_cmd = "tmux split-window -h \\; send-keys " . shellescape(cmd) . " \\; send-keys Left"
  silent execute '!' . shell_cmd
endfunction
nnoremap <silent> <leader>o :call TmuxOpencode()<CR>

" PLUGGED https://github.com/junegunn/vim-plug
" autoinstallation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'

Plug 'airblade/vim-gitgutter'
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
let g:gitgutter_override_sign_column_highlight = 1
set updatetime=300
" Jump between hunks
nmap <Leader>gn <Plug>(GitGutterNextHunk)
nmap <Leader>gp <Plug>(GitGutterPrevHunk)
nmap <Leader>ga <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)

Plug 'ruanyl/vim-gh-line'
let g:gh_line_map = '<leader>gl'
let g:gh_line_blame_map = '<leader>gb'
let g:gh_repo_map = '<leader>go'

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-commentary'
" 'gcc' to comment

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

call plug#end()

" Run PlugInstall if there are missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ============================================================
" => Tmux Integration: RSpec without blocking Vim
" ============================================================
function! TmuxRspec(spec)
  let g:last_rspec_spec = a:spec

  let pane_id = substitute(system("tmux split-window -h -P -F '#{pane_id}'"), '\n', '', 'g')
  if empty(pane_id) | return | endif

  if a:spec == ''
    let rspec_args = ''
  else
    let rspec_args = ' ' . shellescape(a:spec)
  endif

  let cmd = 'cd ' . shellescape(getcwd()) . ' && bundle exec rspec --format progress --require ~/workspace/dotfiles/code/rspec/quickfix_formatter.rb --format QuickfixFormatter --out quickfix.out' . rspec_args
  silent call system('tmux send-keys -t ' . pane_id . ' ' . shellescape(cmd) . ' C-m')
endfunction

" Direct mappings (override vim-rspec defaults after plug#end)
nmap <silent> <Leader>rf :call TmuxRspec(expand('%:p'))<CR>
nmap <silent> <Leader>rt :call TmuxRspec(expand('%:p') . ':' . line('.'))<CR>
nmap <silent> <Leader>rl :call TmuxRspec(get(g:, 'last_rspec_spec', ''))<CR>
nmap <silent> <Leader>ra :call TmuxRspec('')<CR>

" ============================================================
" => Get visual selection helper
" ============================================================
function! GetVisualSelection()
  let [line_start, col_start] = getpos("'<")[1:2]
  let [line_end, col_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][:col_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col_start - 1:]
  return join(lines, "\n")
endfunction

" ============================================================
" => Opencode modes (Normal + Visual)
" ============================================================
function! OpencodeMode(mode, text)
  let full_path = expand('%:p')
  let root_dir = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '\n\+$', '', '')
  if !empty(root_dir)
    let rel_path = substitute(full_path, '^'.escape(root_dir, '\').'/', '', '')
  else
    let rel_path = full_path
  endif
  let ln = line('.')
  let selection = a:text

  if empty(selection)
    if a:mode == 'explain'
      let prompt = "Explain the method at line " . ln . " in " . rel_path . ". Describe inputs, outputs, and side effects."
    elseif a:mode == 'refactor'
      let prompt = "Refactor the code at line " . ln . " in " . rel_path . " to be more idiomatic and efficient. Show the improved code and explain changes."
    elseif a:mode == 'test'
      let prompt = "Generate a comprehensive RSpec test for the code at line " . ln . " in " . rel_path . ". Include edge cases."
    else
      let prompt = a:mode
    endif
  else
    let escaped_selection = substitute(selection, '"', '\\"', 'g')
    if a:mode == 'explain'
      let prompt = "Explain the following Ruby code from " . rel_path . " at line " . ln . ":\n\n" . escaped_selection
    elseif a:mode == 'refactor'
      let prompt = "Refactor the following code from " . rel_path . " at line " . ln . " to be more idiomatic and efficient. Show the improved code and explain changes:\n\n" . escaped_selection
    elseif a:mode == 'test'
      let prompt = "Generate a comprehensive RSpec test for the following code from " . rel_path . " at line " . ln . ". Include edge cases:\n\n" . escaped_selection
    else
      let prompt = a:mode . " (from " . rel_path . " at line " . ln . "):\n\n" . escaped_selection
    endif
  endif

  let cmd = "opencode --prompt \"" . prompt . "\""
  silent call system("tmux split-window -h \\; send-keys " . shellescape(cmd) . " \\; send-keys Left")
endfunction

" Normal mode: use file+line context
nnoremap <silent> <leader>oe :call OpencodeMode('explain', '')<CR>
nnoremap <silent> <leader>or :call OpencodeMode('refactor', '')<CR>
nnoremap <silent> <leader>ot :call OpencodeMode('test', '')<CR>
" Visual mode: yank selection to register z and pass it
vnoremap <silent> <leader>oe "zy:call OpencodeMode('explain', @z)<CR>
vnoremap <silent> <leader>or "zy:call OpencodeMode('refactor', @z)<CR>
vnoremap <silent> <leader>ot "zy:call OpencodeMode('test', @z)<CR>

" ============================================================
" => Tmux logs -> Vim last error
" ============================================================
function! TmuxFindRailsPane()
  let win = substitute(system('tmux display-message -p "#I"'), '\n\+$', '', '')
  let panes = system('tmux list-panes -t work:' . win . ' -F "#{pane_index} #{pane_current_command}"')

  for line in split(panes, '\n')
    let parts = split(line)
    if len(parts) >= 2
      let idx = parts[0]
      let cmd = parts[1]
      if cmd =~ 'puma\|rails\|spring\|ruby'
        return 'work:' . win . '.' . idx
      endif
    endif
  endfor

  " No fallback: let caller handle missing pane
  return ''
endfunction

function! TmuxGotoLastError()
  let pane = TmuxFindRailsPane()
  if empty(pane)
    echo "No Rails pane found"
    return
  endif
  let logs = system('tmux capture-pane -p -t ' . shellescape(pane) . ' | tail -n 100')

  let lines = split(logs, '\n')
  let error_idx = -1

  " Find the last error line (from bottom to top)
  for i in range(len(lines) - 1, 0, -1)
    if lines[i] =~ 'Error\|Exception\|Completed 500\|NameError\|RuntimeError\|NoMethodError\|ArgumentError\|StandardError'
      let error_idx = i
      break
    endif
  endfor

  if error_idx == -1
    echo "No error found in logs"
    return
  endif

  " Find the first file.rb:line after the error (top of the stack trace)
  let last_match = []
  for i in range(error_idx, len(lines) - 1)
    let m = matchlist(lines[i], '\([a-zA-Z0-9_\-/]\+\.rb\):\(\d\+\)')
    if !empty(m)
      let last_match = [m[1], m[2]]
      break
    endif
  endfor

  if empty(last_match)
    echo "No error pattern found in logs"
    return
  endif

  let root = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '\n\+$', '', '')
  if empty(root)
    echo "Not inside a git repository"
    return
  endif
  let full = root . '/' . last_match[0]
  if filereadable(full)
    execute 'tabedit +' . last_match[1] . ' ' . fnameescape(full)
  else
    echo "File not found: " . full
  endif
endfunction
nnoremap <silent> <leader>e :call TmuxGotoLastError()<CR>

" ============================================================
" => Rails test toggle (app <-> spec)
" ============================================================
function! OpenRailsTest()
  let current = expand('%:p')
  let test = substitute(current, 'app/\(.\+\)\.rb', 'spec/\1_spec.rb', '')
  if test == current
    let test = substitute(current, 'lib/\(.\+\)\.rb', 'spec/\1_spec.rb', '')
  endif
  " If already in spec, go back to implementation
  if test == current
    let test = substitute(current, 'spec/\(.\+\)_spec\.rb', 'app/\1.rb', '')
    if test == current
      let test = substitute(current, 'spec/\(.\+\)_spec\.rb', 'lib/\1.rb', '')
    endif
  endif

  if filereadable(test)
    execute 'tabedit ' . fnameescape(test)
  else
    let root = substitute(system('git rev-parse --show-toplevel 2>/dev/null'), '\n\+$', '', '')
    if !empty(root)
      call fzf#run(fzf#wrap({'source': 'find ' . shellescape(root . '/spec') . ' -type f', 'sink': 'tabedit'}))
    else
      echo "Could not find corresponding test file"
    endif
  endif
endfunction
nnoremap <silent> <leader>tt :call OpenRailsTest()<CR>
