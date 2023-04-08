set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
filetype plugin indent on
set number
set noswapfile
set signcolumn=yes
syntax on

let g:python3_host_prog='/data/data/com.termux/files/usr/bin/python3'
let $PYTHONUNBUFFERED=1
let mapleader=' '

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'windwp/nvim-autopairs'
Plug 'one-dark/onedark.nvim'
call plug#end()

colorscheme onedark
vnoremap <silent> # :s/^/#/<CR>:noh<CR>
nnoremap <leader>, :nohlsearch<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>0 :copen<CR><C-w>p:AsyncRun -cwd=$(VIM_FILEDIR) python3 "$(VIM_FILEPATH)"<CR><CR>

augroup qf
  autocmd!
  autocmd FileType qf nnoremap <buffer> q :if &buftype ==# 'quickfix' \| cclose \| else \| q \| endif<CR><CR>
augroup END

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
