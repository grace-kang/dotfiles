set nocompatible              " be iMproved, required
filetype off                  " required
set laststatus=2

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'vim-ruby/vim-ruby'
Plugin 'skwp/greplace.vim'
Plugin 'vim-scripts/tComment'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'gevann/vim-rg'
Plugin 'gevann/vim-rspec-simple'
Plugin 'tpope/vim-unimpaired'

call vundle#end()
filetype plugin indent on

set tabstop=2
set shiftwidth=2
set expandtab
set paste
set autoindent
set number
set clipboard=unnamed

" theme and colors
syntax on
set background=dark
set t_Co=256
colo snow

function! FzyCommand(choice_command, vim_command)
	try
		let output = system(a:choice_command . " | fzy ")
	catch /Vim:Interrupt/
		" Swallow errors from ^C, allow redraw! below
	endtry
	redraw!
	if v:shell_error == 0 && !empty(output)
		exec a:vim_command . ' ' . output
	endif
endfunction

nnoremap <C-p> :call FzyCommand("ag . --silent -l -g ''", ":e")<cr>
nnoremap <leader>e :call FzyCommand("find -type f", ":e")<cr>
nnoremap <leader>v :call FzyCommand("find -type f", ":vs")<cr>
nnoremap <leader>s :call FzyCommand("find -type f", ":sp")<cr>
map <C-n> :NERDTreeToggle<CR>
"Mapping vim-style movement between panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

"map h, j, k, l movements to their g<movement> counterpart
nnoremap j gj
nnoremap k gk
nnoremap J gJ

set incsearch
set lazyredraw
set nobackup
set noswapfile
set showcmd

"resize split windows with + and -
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" Manage vimrc
" Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

function! RSpecCommand(lines)
	let cmd = "! bundle exec rspec " . expand('%') .":" . a:lines
	echom cmd
	exec cmd
endfunction
command! -nargs=1 RSpec :call RSpecCommand(<args>)nnoremap <leader>t :! bundle exec rspec %<cr>
noremap <leader>at :execute "RSpec %"<cr>
noremap <leader>ft :execute "RSpec " . line('.')<cr>
nnoremap <leader>g :call FzyCommand("rg $(bundle show $(bundle list \| tail -n +2 \| cut -f 4 -d' ' \| fzy)) --files -g ''", ":e")<cr>


