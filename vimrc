" PLUGINS
call plug#begin('~/.vim/plugged')

Plug 'jnurmine/Zenburn' " colorschme
Plug 'sheerun/vim-polyglot' " language packs
Plug 'itchyny/lightline.vim' " status line
Plug 'junegunn/goyo.vim' " distraction-free mode
Plug 'rking/ag.vim' " faster search
Plug 'majutsushi/tagbar' " sidebar for tags
Plug 'EinfachToll/DidYouMean' " open the right file
Plug 'justinmk/vim-dirvish' " path navigation
Plug 'easymotion/vim-easymotion' " fast movements
Plug 'tpope/vim-surround' " surroundings
Plug 'tpope/vim-commentary' " comments
Plug 'tpope/vim-abolish' " abbreviation and substitution
Plug 'tpope/vim-repeat' " repeat shortcuts
Plug 'tpope/vim-unimpaired' " bracket shortcuts
Plug 'tpope/vim-dispatch' " async build
Plug 'tpope/vim-fugitive' " git support
Plug 'tpope/vim-speeddating' " date increment
Plug 'tpope/vim-sleuth' " detect indent
Plug 'tpope/vim-jdaddy' " json formatter
Plug 'tpope/vim-characterize' " more info on chars
Plug 'tpope/vim-obsession' " reasy session management
Plug 'tpope/vim-eunuch' " shell commands
Plug 'tpope/vim-rsi' " readline style insertion
Plug 'airblade/vim-gitgutter' " git modifications tracking
Plug 'ntpeters/vim-better-whitespace' " strip whitespaces
Plug 'mtth/scratch.vim' "scratchpad
Plug 'mbbill/undotree' " display the undo tree
Plug 'godlygeek/tabular' " alignment
Plug 'PotatoesMaster/i3-vim-syntax' " i3/config highlighting
Plug 'jez/vim-superman' " man pages support
Plug 'tmux-plugins/vim-tmux' " tmux.conf highlighting
Plug 'ajh17/VimCompletesMe' " tab completion
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim' " fuzzy finder

call plug#end()

" APPEARANCE
" a cool theme
syntax enable
set background=dark
colorscheme zenburn

" GENERAL SETTINGS
" use vim, not vi
set nocompatible
" change leader
let mapleader = ","
" swap
set swapfile
" undo file
set undofile
set undodir=~/.vim/undodir
" always show cursor
set ruler
" show incomplete commands
set showcmd
" incremental searching
set incsearch
" highlight search
set hlsearch
" ignore search case
set ignorecase
" don't ignore search case if capitals
set smartcase
" C-h disable last search highlight
nnoremap <C-h> :nohlsearch<CR>
" consistent n and N behavior
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
" turn indentation on
filetype plugin indent on
" auto indent
set autoindent " then manually either set smartindent or set cindent
" enable filetype plugins
filetype plugin indent on
" turn on line numbers
set number
" utf encoding
set encoding=utf-8
" auto read when modified
set autoread
" auto write when modified
set autowrite
" detect filetypes
filetype on
" hide non-saved buffers
set hidden
" unix formatting
set ff=unix
" buffer navigation
set wildmenu
set wildmode=longest,list,full
" change terminal title
set title
" insert appreciation
set showmode
" don't beep
set noerrorbells
set novisualbell
set t_vb=
" hide mouse while typing
set mousehide
" use mouse
"set mouse=a
" ignore files
set wildignore+=*.o
set wildignore+=**/env/**
" K greps word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" don't show mode
set noshowmode
" proper backspace
set backspace=indent,eol,start
" always show the status bar
set laststatus=2
" insert the right indent
set smarttab
" show invisible chars
"set list
" invisible chars replacements
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·
" horizontal split default location
set splitbelow
" vertical split default location
set splitright
" search files in subdirectories
set path+=**
" 1 line above and below
set scrolloff=1
" fold type
set foldmethod=syntax
" don't fold new buffers
set foldlevelstart=99
" how separations are filled
set fillchars="vert: ,fold:_"
" disable BCE to render colo properly inside GNU screen
if &term =~ '256color'
	set t_ut=
endif
" don't complete included
set complete-=i
" don't complete tags
set complete-=t
" display as much as the lastline
set display=lastline
" see fo-table
set formatoptions+=j
" command history to maximum
set history=10000
" rightly increment numbers
set nrformats="bin,hex"
" don't save options
set sessionoptions-="options"
" increase max number of tabs
set tabpagemax=50
" highlight current line on the current buffer
augroup highlight_follows_focus
	autocmd!
	autocmd WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup END
augroup highligh_follows_vim
	autocmd!
	autocmd FocusGained * set cursorline
	autocmd FocusLost * set nocursorline
augroup END
" more text objects
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
" tags discovery
set tags=./tags;
" line wraping
set textwidth=80

" PLUGIN SETTINGS
" Lightline
let g:lightline = { 'colorscheme': 'default', }

" Ag
if executable('ag')
	" Ag over grep
	set grepprg=ag\ --nogroup\ --nocolor
endif

" Notes
let g:notes_directories = ['~/.notes']

" Goyo
" make :q quit within Goyo
function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction
function! s:goyo_leave()
	" Quit Vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) <= 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Tagbar
nmap <F3> :TagbarToggle<CR>

" Undotree
nmap <F4> :UndotreeToggle<CR>

" FZF
nmap <C-f> :FZF<CR>
