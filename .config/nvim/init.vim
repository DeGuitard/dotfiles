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


""""""""""""""""""""""""""""""
" → Plugin installation
""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-expand-region'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'pangloss/vim-javascript'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo npm install -g tern' }
Plug 'mxw/vim-jsx'
call plug#end()

""""""""""""""""""""""""""""""
" → ALE
""""""""""""""""""""""""""""""
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_fix_on_save = 1


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
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


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
" → Identation and folding settings
""""""""""""""""""""""""""""""
set autoindent
set smartindent
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
