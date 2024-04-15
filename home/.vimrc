set nocompatible              " be iMproved, required
filetype off                  " required

" Vimplug for plugins

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Plug 'tpope/vim-bundler', { 'for': 'ruby' } "disable as clashes with  solargraph
" Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-conflicted'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'easysid/mod8.vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'mustache/vim-mustache-handlebars'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'slashmili/alchemist.vim'
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
Plug 'tpope/gem-ctags'
" Plug 'github/copilot.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-rbenv', { 'for': 'ruby' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wfleming/vim-codeclimate'
Plug 'wincent/terminus'
Plug 'xero/sourcerer'
Plug 'tpope/vim-rbenv'
Plug 'ryanoasis/vim-devicons'
Plug 'hashivim/vim-terraform'
" All of your Plugins must be added before the following line
"
call plug#end() "required

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
let g:airline_theme="base16_ashes"

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
  autocmd BufRead,BufNewFile *jsonschema/* set filetype=json
  autocmd BufRead,BufNewFile *.wfm set filetype=ruby

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
set tabstop=4
set shiftwidth=2
set shiftround
set expandtab

"colors"
set t_Co=256
set wildmenu
" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" if executable('ag')
"   " Use Ag over Grep
"   set grepprg=ag\ --nogroup\ --nocolor

"   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
" endif


autocmd QuickFixCmdPost *grep* nested cwindow|redraw!          " open quickfix window after using Grep, grep, vimgrep
autocmd FileType qf wincmd J

" bind \ (backward slash) to grep shortcut
nnoremap \ :silent Ggrep! ""<left>

" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" nnoremap <silent> \ :Rg<cr>

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Numbers
set number
set numberwidth=5

"refresh file changes
" :set autoread
" Trigger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
" au FocusGained,BufEnter * :silent! e!
" au FocusLost,WinLeave * :silent! noautocmd 

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

" insert print debugging Ruby and Go

function! PrintDebug()
  if &filetype == "go"
     execute "normal! o fmt.Println(\"Debug\")\<ESC>"
  endif
  if &filetype == "ruby"
     execute "normal! op '#' * 10\<ESC>\op 'PUTS DEBUGGING'\<ESC>\op '#' * 10\<ESC>"
  endif
endfunction

nmap <leader>pu :call PrintDebug()<CR>

" nmap <leader>pu op '#' * 10<ESC>op 'PUTS DEBUGGING'<ESC>op '#' * 10<ESC>

" vim-rspec mappings
let g:rspec_command = "call VtrSendCommand('be rspec {spec}')"
"use spring to run tests if project has spring
" autocmd VimEnter * if filereadable("bin/spring") | let g:rspec_command = "call VtrSendCommand('be spring rspec {spec}')" | endif

" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>
" nnoremap <Leader>a :call RunAllSpecs()<CR>
nnoremap <leader>va :VtrAttachToPane<cr>

" Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

" Buffers
:nmap <F5> :buffers<CR>:buffer<Space>
:nmap ] :bnext<CR>
:nmap [ :bprevious<CR>

"serarch Ctrl-p
nnoremap <silent> <C-p> :Files<cr>
nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>, :Buffers<cr>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 

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
" set diffopt+=vertical
" ctlp p install
" set runtimepath^=~/.vim/bundle/ctrlp.vim
" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

au BufNewFile,BufRead *.prawn set filetype=ruby

au BufNewFile,BufRead *.ejs set filetype=html

" presistant undo
set undodir=~/.vim/undodir
set undofile   " Maintain undo history between sessions

" code folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

""coc setup
""" TextEdit might fail if hidden is not set.
"set hidden

"" Give more space for displaying messages.
"set cmdheight=2

"" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" delays and poor user experience.
"set updatetime=300

"" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c

""solargraph
"let g:coc_global_extensions = ['coc-solargraph']

"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

"" Use tab for trigger completion with characters ahead and navigate.
"inoremap <silent><expr> <TAB>
"      \ coc#pum#visible() ? coc#pum#next(1) :
"      \ CheckBackspace() ? "\<Tab>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

"" Make <CR> to accept selected completion item or notify coc.nvim to format
"" <C-g>u breaks current undo, please make your own choice
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

"" Use `[c` and `]c` to navigate diagnostics
"nmap <silent> [c <Plug>(coc-diagnostic-prev)
"nmap <silent> ]c <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use U to show documentation in preview window
"nnoremap <silent> U :call <SID>show_documentation()<CR>

"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)

"" Remap for format selected region
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" let g:go_fmt_command='goimports'
let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1
