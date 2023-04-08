set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
syntax on
filetype plugin indent on
set termguicolors
set number
set noswapfile
set signcolumn=yes
let g:python3_host_prog='/usr/bin/python3'
let $PYTHONUNBUFFERED=1
let mapleader=' '

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'windwp/nvim-autopairs'
Plug 'one-dark/onedark.nvim'
call plug#end()

let g:onedark_terminal_italics=1
let g:onedark_terminal_bold=1
colorscheme onedark

vnoremap <silent> # :s/^/#/<CR>:noh<CR>
nnoremap <leader>, :nohlsearch<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <F9> :copen<CR><C-w>p:AsyncRun -cwd=$(VIM_FILEDIR) python3 "$(VIM_FILEPATH)"<CR><CR>
nnoremap <F10> :copen<CR><C-w>p:AsyncRun -cwd=$(VIM_ROOT) python3 "main.py"<CR><CR>


augroup qf
  autocmd!
  autocmd FileType qf nnoremap <buffer> q :if &buftype ==# 'quickfix' \| cclose \| else \| q \| endif<CR><CR> 
augroup END


function! AsyncrunStop()
  if exists("g:asyncrun_status") && g:asyncrun_status == 'running'
    execute "AsyncStop"
  endif
endfunction
nnoremap <BS> :call AsyncrunStop()<CR>



inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"



inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif



nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd BufRead,BufNewFile *.py let python_highlight_all=1

augroup python_syntax_extra
  autocmd!
  autocmd! Syntax python :syn keyword pythonSelf self
  autocmd! Syntax python :syn keyword pythonCls cls
augroup END
highlight pythonSelf ctermfg=4 guifg=#56b6c2
highlight pythonSelf ctermfg=4 guifg=#56b6c2
nmap <leader>rn <Plug>(coc-rename)

lua << EOF
require("nvim-autopairs").setup {}
EOF
