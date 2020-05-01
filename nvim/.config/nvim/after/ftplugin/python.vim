if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

setlocal colorcolumn=89
setlocal foldmethod=indent
setlocal foldnestmax=2

let b:ale_linters = ['flake8', 'mypy', 'pydocstyle', 'pylint', 'pyls', 'vulture']
let b:ale_fix_on_save = 1
let b:ale_fixers = ['black', 'isort']
call lspsupport#enable()

let test#strategy = 'neoterm'
packadd vim-test

packadd vim-pythonsense
