" Install vim-plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Plugins
call plug#begin(stdpath('data') . '/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf.vim', { 'on': [ 'FZF', 'Rg' ] }
  Plug 'mhinz/vim-signify'
	Plug 'itchyny/lightline.vim'
	Plug 'preservim/nerdtree', { 'on' : 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin', { 'on' : 'NERDTreeToggle' }
call plug#end()

" Auto-install
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" coc
let g:coc_global_extensions = [ 'coc-clangd' ]

" FZF
nnoremap <C-p> :FZF<CR>

" Lightline
let g:lightline = { 'colorscheme' : 'powerline' }
"" Don't show mode
set noshowmode

" NERDTree
map <C-b> :NERDTreeToggle<CR>
"" Autoclose if last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Signify
set updatetime=100

" Settings
set relativenumber
autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set nonumber relativenumber

set tabstop=2
set shiftwidth=2
