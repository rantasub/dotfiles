if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

tnoremap <buffer> <Esc> <Esc>
tnoremap <buffer> <A-e> <C-\><C-n>
