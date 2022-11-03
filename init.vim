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
Plug 'rafi/awesome-vim-colorschemes', Cond(!exists('g:vscode'))
Plug 'joshdick/onedark.vim', Cond(!exists('g:vscode'))

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
" Allow easy incremental increasing and decreasing of dates
Plug 'tpope/vim-speeddating'
" Repeat plugin calls (works great with vim-surround)
Plug 'tpope/vim-repeat'
" Auto pair the brackets
Plug 'jiangmiao/auto-pairs', Cond(!exists('g:vscode'))

" Easymotion plug
" Modern implementation of easymotion for neovim
" Plug 'phaazon/hop.nvim', Cond(!exists('g:vscode'))
" Plug 'phaazon/hop.nvim'
" use the following plugin when in vscode
" Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
" Vim-Leap instead of hop
Plug 'ggandor/leap.nvim'


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

" Distraction-free writing in Vim for Markdown
Plug 'junegunn/goyo.vim', Cond(!exists('g:vscode'))
Plug 'preservim/vim-pencil', Cond(!exists('g:vscode'))
Plug 'dkarter/bullets.vim', Cond(!exists('g:vscode'))
Plug 'preservim/vim-markdown', Cond(!exists('g:vscode'))

" Vimwiki for Zettelkasten
" Plug 'vimwiki/vimwiki', Cond(!exists('g:vscode'))
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'michal-h21/vim-zettel'

" Zettelkasten-Plugin
" Plug 'Furkanzmc/zettelkasten.nvim'
if exists('g:neovide')
" GhostText plugin to use nvim in the browser
Plug 'subnut/nvim-ghost.nvim', {'do': ':call nvim_ghost#installer#install()'}
endif

call plug#end()
" }}}

" SETTINGS ----------------------------------------- {{{
" set noshowmode "hides -- INSERT -- as it's already shown in lightline
set showmatch
set ignorecase
set smartcase
set incsearch
set autochdir
if !exists('g:vscode')
    set termguicolors
    set relativenumber number
    filetype plugin indent on

    set autoindent
    set breakindentopt+=list:-1 " for hanging indents
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set softtabstop=4
    set expandtab
    set linebreak
    syntax on

    set mouse=a
    set scrolloff=10
    set showcmd " show command in status line
    set wildmenu

    " Search 
    set history=1000
endif
" }}}

" MAPPINGS ----------------------------------------- {{{
" keybinds
" Set the space as the leader key. Must be set before other leader key combos!
let mapleader = " "

" Mappings for Neovide
if exists("g:neovide")
    " let g:neovide_fullscreen=v:true
    " delete previous word
    inoremap <C-BS> <C-w>
    " delete next word
    inoremap <C-H> <C-w>
    map <F11> :let g:neovide_fullscreen =! neovide_fullscreen<CR>
    " set the font family and size for Neovide
    set guifont=Sarasa\ Term\ J\ Nerd\ Font:h12
    " undo from insert mode
    inoremap <C-z> <C-o>u 
    " redo from insert mode
    inoremap <C-y> <C-o><C-r> 

    " allow pasting from and copying to the system clipboard with <S-Insert> and <C-Insert>
    " copy the visual selection
    vnoremap <C-Insert> "+y
    vnoremap <C-x> "+d
    " paste from the system clipboard
    inoremap <S-Insert> <C-o>"+p
    nnoremap <S-Insert> "+p
endif

" create undo points for better prose writing
inoremap ! !<C-g>u
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap : :<C-g>u
inoremap ; ;<C-g>u
inoremap ? ?<C-g>u
inoremap ( <C-g>u(
inoremap ) )<C-g>u

" leap.nvim
lua require('leap').add_default_mappings()

" HOP EASYMOTION
" setup and use colemak keys
" lua require'hop'.setup { keys = 'arstdwfpluyhneio', jump_on_sole_occurence = true }
" map <Space>f :HopChar1<CR>
" map <Space>s :HopChar2<CR>
" map <Space>w :HopWord<CR>
" map <Space>l :HopLine<CR>
" map <Space>h :HopLineStart<CR>
" map <Space>t :HopChar1CurrentLineAC<CR>
" map <Space>n :HopChar2CurrentLineAC<CR>
" map <Space>e :HopWordCurrentLineAC<CR>

" map <Leader>f :HopChar1<CR>
" map <Leader>s :HopChar2<CR>
" map <Leader>w :HopWord<CR>
" map <Leader>l :HopLine<CR>
" map <Leader>h :HopLineStart<CR>
" map <Leader>t :HopChar1CurrentLineAC<CR>
" map <Leader>n :HopChar2CurrentLineAC<CR>
" map <Leader>e :HopWordCurrentLineAC<CR>

nmap <Down> gj
nmap <Up> gk
vmap <Down> gj
vmap <Up> gk
imap <Up> <C-o>gk
imap <Down> <C-o>gj

" copy the contents of the entire buffer to system clipboard
nnoremap gca ggVG"+y
" copy selection to the system clipboard
vnoremap gy "+y
" past from the system clipboard
vnoremap gp "+p
vnoremap gP "+P
nnoremap gp "+p
nnoremap gP "+P
" create a markdown link from the clipboard around the current word (uses
" vim_surround)
nmap gl ysiw]f]a(<C-r>+)<Esc>

if !exists('g:vscode')

    " delete ahead
    inoremap <C-Del> <C-o>de

    " display the current full path of the file
    noremap <C-g><C-g> 1<C-g>

    " pull the path of the current file into the clipboard
    noremap <C-p>y :let @+ = expand("%:p:h")<CR>:pwd<CR>

    " change the working directory to the current file location
    noremap <C-p>c :cd %:p:h<CR>:pwd<CR>

    " traverse the buffer list (taken from Practical Vim)
    nnoremap <silent> [b :bprevious<CR>
    nnoremap <silent> ]b :bnext<CR>
    nnoremap <silent> [B :bfirst<CR>
    nnoremap <silent> ]B :blast<CR>

    " open nerdtree with F1
    nnoremap <F1> :NERDTreeToggle<CR>
    " Have nerdtree ignore certain files and directories.
    let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

    " Set the location of Tagbar
    let g:tagbar_ctags_bin = 'C:\Users\jakob\AppData\Local\ctags\ctags.exe'
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

    " Disable the ge command override from vim-markdown
    map <Plug> <Plug>Markdown_EditUrlUnderCursor

    " Save with Ctrl-S
    nnoremap <C-s> :w<CR>
    inoremap <C-s> <C-o>:w<CR>

endif

" Yank from cursor to the end of line.
nnoremap Y y$

" }}}

" COLORSCHEMES ------------------------------------- {{{
let g:onedark_hide_endofbuffer=1
" let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
let g:lightline = {
            \ 'colorscheme': 'onedark'
            \ }
colorscheme onedark
"

" }}}

" VIMSCRIPT ---------------------------------------- {{{
" This will enable code folding.
" Use the marker method of folding.
if !exists('g:vscode')

    " Disable AutoPairsMultilineClose
    let g:AutoPairsMultilineClose = 0

    " Automatically recognize markdown files
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    autocmd BufNewFile,BufFilePre,BufRead *.md set syntax=markdown

    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END

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

    " " Bullets.vim
    let g:bullets_enabled_file_types = [
        \ 'markdown',
        \ 'md',
        \ 'text',
        \ 'gitcommit',
        \ 'scratch'
        \]
    let g:bullets_enable_in_empty_buffers = 1

    " setup for zettelkasten.nvim
    " lua require'zettelkasten'.setup { notes_path = 'C:\\Users\\jakob\\OneDrive\\_ZETTELKASTEN' }
    " setup of vim-zettel
    " let g:nv_search_paths = ['C:\\Users\\jakob\\OneDrive\\_ZETTELKASTEN']
    " setup of vimwiki
    " let g:vimwiki_conceallevel = 0

    " Change the level for syntax concealment (2 per default)
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_folding_level = 2

endif

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
