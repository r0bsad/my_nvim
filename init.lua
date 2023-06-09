-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.python3_host_prog='/home/wakeup/coding/envmath/bin/python'
vim.g.airline_theme='oceanicnext'
vim.g.mapleader = " " 
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 5000
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.scrolloff= 7
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.fileformat = 'unix'
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug "rebelot/kanagawa.nvim"  --colorscheme
Plug 'morhetz/gruvbox' --colorscheme
Plug 'mhartington/oceanic-next'  --colorscheme
Plug('neoclide/coc.nvim', {branch='release'})
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', {branch='0.1.x'})
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'windwp/nvim-autopairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'm-demare/hlargs.nvim'
vim.call('plug#end')

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}
require("nvim-tree").setup({
  view = {
        width = 30,
  }
})

require("nvim-tree.view").is_visible()
require("nvim-autopairs").setup()
require('hlargs').setup {
		paint_arg_declarations = true,
}

local keyset = vim.keymap.set
keyset("n", ";", ":", {noremap = true})
keyset("n", "<leader>s", ":%s/", {noremap = true})
--keyset("n", "w<right>", ":vsplit<CR>", {noremap = true})
--keyset("n", "<leader>wo", ":tab vsplit<CR>", {noremap = true})
keyset("v", "<c-right>", ":s/^/#/<CR>:noh<CR>", {silent = true, noremap = true})
keyset("v", "<c-left>", ":s/^#//<CR>:noh<CR>", {silent = true, noremap = true})
keyset("n", "<leader>0", ":w <bar> :exec '!python' shellescape(@%, 1)<cr>", {buffer = true, noremap = true})
keyset("n", "<leader>e", ":NvimTreeToggle<CR>")
keyset("n", "<leader>f", ":NvimTreeFocus<CR>")

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


function get_buffer_id()
    local buffer_id = vim.api.nvim_win_get_buf(0)
    print('winId:', buffer_id)
end
keyset("n", "w<right>", "<CMD>lua get_buffer_id()<CR>", {noremap = true})


--Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

function _G.check_back_space()
   local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

vim.cmd [[
  syntax enable
  filetype plugin indent on
  colorscheme kanagawa
]]
