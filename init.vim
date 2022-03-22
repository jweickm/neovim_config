""" Jakob's Neovim init.vim
" PLUGINS ------------------------------------------ {{{
" Custom Cond helper function from https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin(stdpath('config') . '/plugged')

" Aesthetics - Status Line
Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode'))
" Plug 'vim-airline/vim-airline'

" Aesthetics - Additional
" Fancy Startpage for vim
Plug 'mhinz/vim-startify', Cond(!exists('g:vscode'))
"color name highlighter
Plug 'ap/vim-css-color', Cond(!exists('g:vscode'))

" COLORSCHEMES
" Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'rafi/awesome-vim-colorschemes', Cond(!exists('g:vscode'))

" Git Plugins
Plug 'airblade/vim-gitgutter', Cond(!exists('g:vscode'))
Plug 'tpope/vim-fugitive'

" Vim Terminal
Plug 'tc50cal/vim-terminal', Cond(!exists('g:vscode'))

" NERDTREE plugin for easier file browsing
Plug 'preservim/nerdtree', Cond(!exists('g:vscode'))
Plug 'ryanoasis/vim-devicons'

" Comment stuff out with gcc
Plug 'tpope/vim-commentary'
" Surround stuff with ys
Plug 'tpope/vim-surround'
" Auto pair the brackets
Plug 'jiangmiao/auto-pairs'

" Easymotion plug
" Plug 'easymotion/vim-easymotion'
" Make Easymotion work with dot repeat
Plug 'tpope/vim-repeat'
" Modern implementation of easymotion for neovim
Plug 'phaazon/hop.nvim', Cond(!exists('g:vscode'))
" use the following plugin when in vscode
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })


" Better registers
Plug 'junegunn/vim-peekaboo', Cond(!exists('g:vscode'))
" Plug 'neoclide/coc.nvim' " Auto Completion (requires some more setup) only
" active in WSL
Plug 'preservim/tagbar', Cond(!exists('g:vscode')) " Add a tagbar to neovim (Toggle with F8)

" Fuzzy search with Telescope
Plug 'nvim-lua/plenary.nvim', Cond(!exists('g:vscode')) " required dependency
Plug 'nvim-telescope/telescope.nvim', Cond(!exists('g:vscode'))

" Smooth Scrolling
Plug 'psliwka/vim-smoothie', Cond(!exists('g:vscode'))

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim', Cond(!exists('g:vscode'))

call plug#end()
" }}}

" SETTINGS ----------------------------------------- {{{
if exists('g:vscode')
    set showmatch
    set ignorecase
    set smartcase
    set hlsearch
    set incsearch
else
    set relativenumber
    filetype plugin indent on

    set autoindent
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set softtabstop=4
    set expandtab
    syntax on

    set mouse=a
    set scrolloff=20
    set showcmd " show command in status line
    set wildmenu

    " Search 
    set showmatch
    set ignorecase
    set smartcase
    set hlsearch
    set incsearch

    set history=1000
endif
" }}}

" MAPPINGS ----------------------------------------- {{{
" Set the space as the leader key. Must be set before other leader key combos!
let mapleader = " "

if exists('g:vscode')
     " Map easymotion to only leader (after setting the mapleader!)
     map <Leader> <Plug>(easymotion-prefix)
     map <Leader>f <Plug>(easymotion-f)
     map <Leader>F <Plug>(easymotion-F)
     map <Leader>L <Plug>(easymotion-bd-jk)
     " Move to word
     map  <Leader>w <Plug>(easymotion-bd-w)
     " Move two chars
     nmap <Leader>s <Plug>(easymotion-bd-f2)
    
else 
    " HOP EASYMOTION
    " setup and use colemak keys
    lua require'hop'.setup { keys = 'arstdwfpluyhneio', jump_on_sole_occurence = false }
    map <Leader>f :HopChar1<CR>
    map <Leader>s :HopChar2<CR>
    map <Leader>w :HopWord<CR>
    map <Leader>l :HopLine<CR>
    map <Leader>h :HopLineStart<CR>

    " open nerdtree with F1
    nnoremap <F1> :NERDTreeToggle<CR>
    " Have nerdtree ignore certain files and directories.
    let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

    " Open the Tagbar with F8
    nmap <F8> :TagbarToggle<CR>

    " Switch buffers with F5
    nnoremap <F5> :buffers<CR>:buffer<Space>

    " FOR TELESCOPE FINDER
    " Find files using Telescope command-line sugar.
    " nnoremap <leader>ff <cmd>Telescope find_files<cr>
    " nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    " nnoremap <leader>fb <cmd>Telescope buffers<cr>
    " nnoremap <leader>fh <cmd>Telescope help_tags<cr>

    " Using Lua functions
    nnoremap <leader><leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
    nnoremap <leader><leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader><leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
    nnoremap <leader><leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
endif

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing ALT+H, ALT+J, ALT+K, or ALT+L.
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-h> <c-w>h
nnoremap <a-l> <c-w>l


" }}}

" COLORSCHEMES ------------------------------------- {{{
" let g:gruvbox_baby_transparent_mode = 1 
" colorscheme gruvbox-baby
"

" }}}

" VIMSCRIPT ---------------------------------------- {{{
" This will enable code folding.
" Use the marker method of folding.
if exists('g:vscode')
else 
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END
endif
" }}}

" STATUS LINE -------------------------------------- {{{
" }}}
