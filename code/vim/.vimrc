" https://github.com/amix/vimrc
set history=500
" https://www.youtube.com/watch?v=XA2WjJbmmoM
set path+=**

" Set to auto read when a file is changed from the outside
set autoread | au CursorHold * checktime | call feedkeys("jk")

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

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

" Copy to clipboard, It needs gvim to be installed
vmap <C-y> "+y"

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
nnoremap tt :Texplore<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

imap jj <Esc>
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>n :tabedit <C-r>=expand("%:p:h")<CR>/<CR>

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
" => Save last session
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

if !exists("g:avoidSession")
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession()
end


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
nmap <F6> I
let g:netrw_banner = 0
map <C-b> :Lexplore<cr>

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

" PLUGGED https://github.com/junegunn/vim-plug
" autoinstallation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
"Plug 'junegunn/seoul256.vim'
"Plug 'junegunn/goyo.vim'
"Plug 'junegunn/limelight.vim'
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

Plug 'thoughtbot/vim-rspec'
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rt :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

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
