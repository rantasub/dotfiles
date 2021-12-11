if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

setlocal colorcolumn=89
setlocal foldmethod=indent
setlocal foldnestmax=2

let test#strategy = 'neoterm'
packadd vim-test

packadd vim-pythonsense
