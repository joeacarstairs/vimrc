let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
	execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " .shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))


"*******************************************************************************
"" NERDTree
"*******************************************************************************

Plug 'scrooloose/nerdtree' "NERDTree: tree view of workspace. :help nerdtree
Plug 'jistr/vim-nerdtree-tabs' " Make NERDTree behave like a GUI side panel. :help nerdtree-tabs

let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-S-n> :NERDTreeFocusToggle<CR>
nnoremap <silent> <leader>n :NERDTreeFind<CR>


"*******************************************************************************
"" Git
"*******************************************************************************

Plug 'tpope/vim-fugitive' " Git plugin. :help fugitive
Plug 'tpope/vim-rhubarb' " Required by fugitive to :GBrowse
Plug 'airblade/vim-gitgutter' " Shows git diff indicators in the gutter, adds hunk textobject, and adds functions for staging/undoing hunks. :help gitgutter

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

noremap <leader>gw :Gwrite<CR>
noremap <leader>gc :Git commit --verbose
noremap <leader>gsh :Git push<CR>
noremap <leader>gl :Gclog<CR>
noremap <leader>gll :Git pull<CR>
noremap <leader>gs :Git<CR>
noremap <leader>gb :Git blame<CR>
noremap <leader>gd :Gvdiffsplit<CR>
noremap <leader>gr :GRemove<CR>


"*******************************************************************************
"" Statusline
"*******************************************************************************

Plug 'vim-airline/vim-airline' " Statusline at the bottom of each window. :help airline
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline/vim-airline. Switch theme with :AirlineTheme <theme>. :help airline-themes.txt

let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep = '▶'
  let g:airline_left_alt_sep = '»'
  let g:airline_right_sep = '◀'
  let g:airline_right_alt_sep = '«'
  left g:airline#extensions#branch#prefix = '⤴'
  let g:airline#extensions#readonly#symbol = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol = 'ρ'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif


"*******************************************************************************
"" Session management
"*******************************************************************************

Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_command_aliases = 1

nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>


"*******************************************************************************
"" Miscellaneous plugins
"*******************************************************************************

Plug 'tpope/vim-commentary' " Un/comment stuff with [count]gcc, gc<motion>, gc. :help commentary
Plug 'vim-scripts/grep.vim' " :Grep, :Rgrep, :Bgrep etc
Plug 'vim-scripts/CSApprox' " Adapts gVim themes to terminal Vim
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 1
Plug 'dense-analysis/ale' " linting and indenting
let g:ale_linters = {}
Plug 'Yggdroot/indentLine'
Plug 'joeacarstairs/alabaster-dark-neon.vim'

"Plug 'lambdalisue/vim-nerdfont'
Plug 'ryanoasis/vim-devicons' " For displaying nerd font icons eg in file trees, status lines, etc
Plug 'tpope/vim-sleuth' " Auto-detects shiftwidth, expandtab etc based on file contents, editorconfig etc
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP server

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"" fzf.vim
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' } " Shows file previews in fuzzy file picker
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif
" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif





"*******************************************************************************
"" Custom bundles
"*******************************************************************************

" html
"" HTML Bundle
Plug 'hail2u/vim-css3-syntax' " CSS3 syntax
"Plug 'gko/vim-coloresque' " Colour previews in CSS
Plug 'tpope/vim-haml' " HAML, SCSS and Sass features
Plug 'mattn/emmet-vim' " Expand emmet abbreviations with <C-y> (default)

" javascript
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax' " JavaScript syntax

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'


"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Mappings
"*****************************************************************************

" Open fuzzy finder (fzf.vim)
nnoremap <silent> <C-p> :FZF -m<CR>

" List active buffers (fzf.vim)
nnoremap <silent> <leader>b :Buffers<CR>

" grep in open workspace (grep.vim)
nnoremap <silent> <leader>/ :Rgrep<CR>

"" LSP actions
" Tab either triggers completion, or cycles through completion options
" Not sure what <C-h> is for...?
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Navigate diagnostics
nnoremap <silent> [d <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]d <Plug>(coc-diagnostic-next)
" GoTo code navigation
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
" Hover
nnoremap <silent> <leader>k :call ShowDocumentation()<CR>
" Rename
nnoremap <leader>r <Plug>(coc-rename)
" Formatting selected code
xnoremap <leader>f <Plug>(coc-format-selected)
nnoremap <leader>f <Plug>(coc-format-selected)
" Code actions
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-cursor)
nmap <leader>ab <Plug>(coc-codeaction-source)
" Refactoring actions
nmap <leader>rf <silent> <Plug>(coc-codeaction-refactor)
xmap <leader>rf <silent> <Plug>(coc-codeaction-refactor-selected)

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>

"*****************************************************************************
"" Functions
"*****************************************************************************

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover)
        call CocActionAsync('doHover')
    else
           call feedkeys('K', 'in')
    endif
endfunction

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

"" coc.nvim extensions
" For up-to-date list, see:
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
let g:coc_global_extensions = [
    \ 'coc-angular',
    \ 'coc-css',
    \ 'coc-cssmodules',
    \ 'coc-diagnostic',
    \ 'coc-docker',
    \ 'coc-eslint',
    \ 'coc-fzf-preview',
    \ 'coc-git',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-htmlhint',
    \ 'coc-html-css-support',
    \ 'coc-java',
    \ 'coc-json',
    \ 'coc-markdownlint',
    \ 'coc-prettier',
    \ 'coc-tsserver',
    \ 'coc-yaml',
\]
autocmd VimEnter silent * CocUpdate

"" CoC workspace roots
autocmd FileType typeescript let b:coc_root_patterns ['tsconfig.json', 'package.json', 'yarn.lock', '.git']

