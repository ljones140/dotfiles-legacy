set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdTree'
Plugin 'thoughtbot/vim-rspec'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'xero/sourcerer'
Plugin 'christoomey/vim-conflicted'
Plugin 'suan/vim-instant-markdown'
Plugin 'ngmy/vim-rubocop'
Plugin 'tpope/vim-rails'
Plugin 'easysid/mod8.vim'
Plugin 'godlygeek/tabular'
Plugin 'rking/ag.vim'
Plugin 'ervandew/supertab'
Plugin 'chriskempson/base16-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'rodjek/vim-puppet'
Plugin 'jgdavey/vim-blockle'
Plugin 'jreybert/vimagit'
Plugin 'idanarye/vim-merginal'
Plugin 'elixir-lang/vim-elixir'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rbenv'
Plugin 'floobits/floobits-neovim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/gem-ctags'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-obsession'
Plugin 'slashmili/alchemist.vim'
Plugin 'wfleming/vim-codeclimate'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-dadbod'

" All of your Plugins must be added before the following line

call vundle#end()            " required

filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

"speed up escape
set timeoutlen=1000 ttimeoutlen=0

" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set ignorecase    " So that supertab doesn't give tag not sorted error with nvim

"colorscheme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set nohlsearch "get rid of yellow line in neovim

"Vim tmux runner
nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>
nnoremap <leader>otr :VtrOpenRunner {'orientation': 'h', 'percentage': 50 }<cr>
nnoremap <leader>sa :VtrSendFile<cr>

"Airline config"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

autocmd VimResized * :wincmd = " automatically rebalance windows on vim resize

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell
  autocmd FileType cucumber setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

"colors"
set t_Co=256
set wildmenu
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

autocmd QuickFixCmdPost *grep* nested cwindow|redraw!          " open quickfix window after using Grep, grep, vimgrep
autocmd FileType qf wincmd J

" bind \ (backward slash) to grep shortcut
nnoremap \ :silent Ggrep! ""<left>

" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut

" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" nnoremap \ :Ag<SPACE>

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

"refresh file changes
:set autoread

"delete to buffer
nmap <leader>dd "bd

"pasting
set clipboard=unnamed
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" vim-jsx syntax highlighting for jsx in .js
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>
" nerdtree map
map <C-n> :NERDTreeToggle<CR>
" Switch between the last two files
nnoremap <leader><leader> <c-^>
" Find file in tree
nnoremap <leader>nf :NERDTreeFind<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" insert lines outside in view mode
nmap go o<ESC>k
nmap gO O<ESC>j
nmap gr o<ESC>kO<ESC>j

"insert require pry
nmap <leader>py orequire "pry"; binding.pry<ESC>

" insert puts debugging
nmap <leader>pu op '#' * 10<ESC>op 'PUTS DEBUGGING'<ESC>op '#' * 10<ESC>

" vim-rspec mappings
let g:rspec_command = "call VtrSendCommand('be rspec {spec}')"
"use spring to run tests if project has spring
autocmd VimEnter * if filereadable("bin/spring") | let g:rspec_command = "call VtrSendCommand('be spring rspec {spec}')" | endi

nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>
nnoremap <leader>va :VtrAttachToPane<cr>


" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Buffers
:nmap <F5> :buffers<CR>:buffer<Space>
:nmap ] :bnext<CR>
:nmap [ :bprevious<CR>

"ctage Ctrl-p
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>, :CtrlPBuffer<cr>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

"line number toggle
nnoremap <leader>nt :call NumberToggle()<cr>

" relative path  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>

" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" on wrapped lines move normall
nnoremap j gj
nnoremap k gk

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

"use tabularize to align as soon as pipe is entered

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" vim Conflicted status lin integration
set stl+=%{ConflictedVersion()}

" Always use vertical diffs
set diffopt+=vertical
" ctlp p install
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" presistant undo
set undodir=~/.vim/undodir
set undofile   " Maintain undo history between sessions
