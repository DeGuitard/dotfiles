""""""""""""""""""""""""""""""
" → vim configuration
""""""""""""""""""""""""""""""
set number
set relativenumber
set autoread
set smartcase

" Persists and limit vim commands history
set history=500
set undodir=~/..local/share/nvim/undo
set undofile

let mapleader=","

" Fast saving & force saving
nmap <leader>w :w!<cr>
command W w !sudo tee % > /dev/null

" Search configuration
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>

" Indent cofiguration
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Elixir shortcuts
augroup elixir
    autocmd FileType elixir nnoremap <c-k> :ALEGoToDefinition<cr>
augroup END

""""""""""""""""""""""""""""""
" → Plugin installation
""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
" File search / management
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'itchyny/lightline.vim'
Plug 'maxbrunsfeld/vim-yankstack'

" Linting / Formatting
Plug 'w0rp/ale'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" JS
Plug 'pangloss/vim-javascript'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo npm install -g tern' }
Plug 'mxw/vim-jsx'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" Python
Plug 'deoplete-plugins/deoplete-jedi'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
call plug#end()

""""""""""""""""""""""""""""""
" → ALE
""""""""""""""""""""""""""""""
let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls']
let g:ale_linters.rust = ['rls']
let g:ale_linters.python = ['flake8']

let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier', 'eslint']
let g:ale_fixers.python = ['autopep8', 'yapf']
let g:ale_fixers.elixir = ['mix_format']
let g:ale_fix_on_save = 1

let g:ale_elixir_elixir_ls_release = '/home/lain/dev/elixir-ls/rel'


""""""""""""""""""""""""""""""
" → Lightline
""""""""""""""""""""""""""""""
let g:lightline = {
  \ 'colorscheme': 'seoul256',
\ }


""""""""""""""""""""""""""""""
" → Deoplete
""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#ternjs#tern_bin = '/usr/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#types = 1
" call deoplete#custom#source('buffer', 'min_pattern_length', 0)
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


""""""""""""""""""""""""""""""
" → Neosnippet
""""""""""""""""""""""""""""""
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? 
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


""""""""""""""""""""""""""""""
" → YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd', 'c']
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" → NERDTree
""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""
" → BufExplorer
""""""""""""""""""""""""""""""
map <leader>o :BufExplorer<cr>
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1 


"""""""""""""""""""""""""""""
" → ctrlp
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" → Tern.js
""""""""""""""""""""""""""""""
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
nmap <leader>d :TernDef<enter>
nmap <C-x><C-g> :TernRefs<enter>
nmap <C-x><C-r> :TernRename<enter>


""""""""""""""""""""""""""""""
" → vim-racer
""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1
let g:rust_fold = 1


""""""""""""""""""""""""""""""
" → vim-racer
""""""""""""""""""""""""""""""
set hidden
let g:racer_cmd = "/home/lain/.cargo/bin/racer"
let g:racer_experimental_completer = 1


""""""""""""""""""""""""""""""
" → Identation and folding settings
""""""""""""""""""""""""""""""
set autoindent
set smartindent
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
