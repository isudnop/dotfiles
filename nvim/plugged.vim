if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" File explorer
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Editing
Plug 'remko/detectindent'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Townk/vim-autoclose'
Plug 'itchyny/vim-parenmatch'
Plug 'terryma/vim-multiple-cursors'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

" Syntax Highlight
Plug 'lilydjwg/colorizer'
Plug 'sheerun/vim-polyglot'

" Languages
Plug 'isRuslan/vim-es6'
Plug 'moll/vim-node'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'

" Git
Plug 'airblade/vim-gitgutter'

" Other
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-sensible'

" Color scheme
Plug 'rakr/vim-one'

Plug 'ryanoasis/vim-devicons'

call plug#end()

colorscheme one
set background=dark

" start NERDTree on startup
autocmd VimEnter * NERDTree
let NERDTreeSortHiddenFirst = 1
let NERDTreeChDirMode = 2
let NERDTreeHijackNetrw = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['\.git$[[dir]]','\.DS_Store$[[file]]']

" Rg command tweaks to search only file content
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Coc
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-rls',
  \ 'coc-yaml',
  \ 'coc-python',
  \ 'coc-emmet',
  \ ]

" Lightline
let g:lightline = {
  \ 'colorscheme': 'one',
  \ }