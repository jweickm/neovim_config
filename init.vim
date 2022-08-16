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
" Catppuccin theme for nvim
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

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
Plug 'jiangmiao/auto-pairs', Cond(!exists('g:vscode'))

" Easymotion plug
" Make Easymotion work with dot repeat
Plug 'tpope/vim-repeat', Cond(!exists('g:vscode'))
" Modern implementation of easymotion for neovim
" Plug 'phaazon/hop.nvim', Cond(!exists('g:vscode'))
Plug 'phaazon/hop.nvim'
" use the following plugin when in vscode
" Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })


" Better registers
Plug 'junegunn/vim-peekaboo', Cond(!exists('g:vscode'))
" Plug 'neoclide/coc.nvim' " Auto Completion (requires some more setup) only
" active in WSL
Plug 'preservim/tagbar', Cond(!exists('g:vscode')) " Add a tagbar to neovim (Toggle with F8)

" Minimap
Plug 'wfxr/minimap.vim', Cond(!exists('g:vscode'))

" Vim Table Mode
Plug 'dhruvasagar/vim-table-mode', Cond(!exists('g:vscode'))

" Fuzzy search with Telescope
Plug 'nvim-lua/plenary.nvim', Cond(!exists('g:vscode')) " required dependency
Plug 'nvim-telescope/telescope.nvim', Cond(!exists('g:vscode'))

" Smooth Scrolling
Plug 'psliwka/vim-smoothie', Cond(!exists('g:vscode'))

" Distraction-free writing in Vim
Plug 'junegunn/goyo.vim', Cond(!exists('g:vscode'))
Plug 'preservim/vim-pencil', Cond(!exists('g:vscode'))

" GhostText plugin to use nvim in the browser
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

" Board plugin to take quick notes
" Plug 'azabiong/vim-board', Cond(!exists('g:vscode'))
" Vimwiki
Plug 'vimwiki/vimwiki', Cond(!exists('g:vscode'))

" Thunderbird NVIM Plugin
" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()
" }}}

" SETTINGS ----------------------------------------- {{{
if exists('g:vscode')
    set showmatch
    set ignorecase
    set smartcase
    set incsearch
else
    set relativenumber number
    filetype plugin indent on

    set autoindent
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set softtabstop=4
    set expandtab
    set linebreak
    syntax on

    set mouse=a
    set scrolloff=20
    set showcmd " show command in status line
    set wildmenu

    " Search 
    set showmatch
    set ignorecase
    set smartcase
    set incsearch

    set history=1000
endif
" }}}

" MAPPINGS ----------------------------------------- {{{
" keybinds
" Set the space as the leader key. Must be set before other leader key combos!
" let mapleader = " "

" HOP EASYMOTION
" setup and use colemak keys
lua require'hop'.setup { keys = 'arstdwfpluyhneio', jump_on_sole_occurence = true }
map <Space>f :HopChar1<CR>
map <Space>s :HopChar2<CR>
map <Space>w :HopWord<CR>
map <Space>l :HopLine<CR>
map <Space>h :HopLineStart<CR>
map <Space>t :HopChar1CurrentLineAC<CR>
map <Space>n :HopChar2CurrentLineAC<CR>
map <Space>e :HopWordCurrentLineAC<CR>
" map <Leader>f :HopChar1<CR>
" map <Leader>s :HopChar2<CR>
" map <Leader>w :HopWord<CR>
" map <Leader>l :HopLine<CR>
" map <Leader>h :HopLineStart<CR>
" map <Leader>t :HopChar1CurrentLineAC<CR>
" map <Leader>n :HopChar2CurrentLineAC<CR>
" map <Leader>e :HopWordCurrentLineAC<CR>

nmap <Down> gj
vmap <Down> gj
nmap <Up> gk
vmap <Up> gk
imap <Down> <C-o>gj
imap <Up> <C-o>gk

" copy the contents of the entire buffer to system clipboard
nmap gca ggVG"+y
" copy selection to the system clipboard
vmap gy "+y

if exists('g:vscode')

else 

    " display the current full path of the file
    noremap <C-g><C-g> 1<C-g>

    " pull the path of the current file into the clipboard
    noremap <C-p> :let @+ = expand("%:p:h")<CR>:pwd<CR>

    " traverse the buffer list (taken from Practical Vim)
    nnoremap <silent> [b :bprevious<CR>
    nnoremap <silent> ]b :bnext<CR>
    nnoremap <silent> [B :bfirst<CR>
    nnoremap <silent> ]B :blast<CR>

    " open nerdtree with F1
    nnoremap <F1> :NERDTreeToggle<CR>
    " Have nerdtree ignore certain files and directories.
    let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

    " Open the Tagbar with F8
    nmap <F8> :TagbarToggle<CR>

    " Switch buffers with F5
    nnoremap <F5> :buffers<CR>:buffer<Space>

    " Toggle Minimap with LeaderM
    nnoremap <Leader>m :MinimapToggle<CR>

    " Change the format of the vim-table-mode
    let g:table_mode_corner='|'

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

    " Center the cursor vertically when moving to the next word during a search.
    nnoremap n nzz
    nnoremap N Nzz

    " You can split the window in Vim by typing :split or :vsplit.
    " Navigate the split view easier by pressing ALT+H, ALT+J, ALT+K, or ALT+L.
    nnoremap <a-j> <c-w>j
    nnoremap <a-k> <c-w>k
    nnoremap <a-h> <c-w>h
    nnoremap <a-l> <c-w>l

    " Disable AutoPairsMultilineClose
    let g:AutoPairsMultilineClose = 0

endif

" Yank from cursor to the end of line.
nnoremap Y y$

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

" This function is from Practical Vim, but taken from https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
" it allows pressing @ to execute a macro over all lines in the visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

else 
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END
endif

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Call the writing plugin 'pencil', when editing markdown files
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,md  call pencil#init()
  autocmd FileType text             call pencil#init()
augroup END

" This function is from Practical Vim, but taken from https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
" it allows pressing @ to execute a macro over all lines in the visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
" }}}

" STATUS LINE -------------------------------------- {{{
" }}}
