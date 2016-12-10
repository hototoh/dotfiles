let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

let s:path = expand('~/.vim/dein')
if !dein#load_state(s:path)
  finish
endif

call dein#begin(s:path, expand('<sfile>'))

call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
  " Installation check.
  call dein#install()
endif

filetype plugin indent on
syntax enable

