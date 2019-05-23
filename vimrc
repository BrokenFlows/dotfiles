" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" line numbering
set number

" spell checking for LaTeX files
"autocmd FileType tex setlocal spell spelllang=en_gb
set spelllang=en_gb
autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile *.md setlocal spell

" set clipboard to work with yank
set clipboard=unnamed

" should allow tabs to be of width 4
set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab

" background change(?)
" Didn't work: set background=light

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=r
endif

" Abandoned buffers are just hidden
set hidden

" Keep window sizes roughly as they were when closing a window
set noea " noequalalways

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
"  syntax enable
  "colorscheme monokai
  colorscheme monokai-tasty
  "colorscheme hashpunk
  "colorscheme hashpunk-sweet
  "colorscheme hashpunk-lapis
  "colorscheme apprentice " dark low contrast blues and greens
  "colorscheme blaaark " dark with contrast and reds
  "colorscheme lucius " dark with blues greens and yellows
  "LuciusDarkHighContrast " better lucius
endif

" Status Line {
	set laststatus=2                             " always show statusbar
	set statusline=
	set statusline+=%-3n\                        " buffer number
	set statusline+=%f\                          " filename
	set statusline+=%h%m%r%w                     " status flags
	set statusline+=%=                           " right align remainder
	set statusline+=%-14(%l,%c%V%)               " line, character
	set statusline+=%<%P                         " file position
"}

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" vim packages here:
set packpath+=~/.vim/pack/
set rtp+=/usr/local/opt/fzf

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	  \ | wincmd p | diffthis
endif
