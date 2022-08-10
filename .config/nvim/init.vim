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
Plug 'jlanzarotta/bufexplorer'
Plug 'mileszs/ack.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'itchyny/lightline.vim'
Plug 'maxbrunsfeld/vim-yankstack'

" Linting / Formatting
Plug 'w0rp/ale'

" Autocompletion
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }

" Git
Plug 'tpope/vim-fugitive'

" Terraform
Plug 'hashivim/vim-terraform'

call plug#end()

""""""""""""""""""""""""""""""
" → ALE
""""""""""""""""""""""""""""""
let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls']
let g:ale_linters.rust = ['rls']
let g:ale_linters.python = ['flake8']
let g:ale_linters.javascript = []
let g:ale_linters.typescript = []

let g:ale_fixers = {}
let g:ale_fixers.javascript = []
let g:ale_fixers.typescript = []
let g:ale_fixers.python = ['autopep8', 'yapf']
let g:ale_fixers.elixir = ['mix_format']
let g:ale_fix_on_save = 1

let g:ale_disable_lsp = 1
let g:ale_elixir_elixir_ls_release = '/home/lain/dev/elixir-ls/rel'

""""""""""""""""""""""""""""""
" → coc
""""""""""""""""""""""""""""""
let g:coc_global_extensions = ['coc-tsserver']
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>cl  <Plug>(coc-codelens-action)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


let g:coc_enable_locationlist = 0
autocmd User CocLocationsChange CocList --no-quit --normal location

nmap <leader>u <Plug>(coc-references)

nnoremap Ï :CocNext<cr>
nnoremap È :CocPrev<cr>

autocmd VimEnter,ColorScheme * hi! link CocFloating CocHintFloat

""""""""""""""""""""""""""""""
" → Lightline
""""""""""""""""""""""""""""""
let g:lightline = {
            \ 'colorscheme': 'seoul256',
            \ }


""""""""""""""""""""""""""""""
" → Fugitive
""""""""""""""""""""""""""""""
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>


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
" → Telescope
""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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
" → elixir.nvim
""""""""""""""""""""""""""""""
let g:elixir_autobuild = 1
let g:elixir_showerror = 1

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
