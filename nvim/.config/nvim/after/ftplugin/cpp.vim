if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

setlocal formatprg=clang-format

function! FormatCurrentBuffer()
    let view = winsaveview()
    :keepjumps normal! gggqG
    call winrestview(view)
endfunction

augroup AutoFormatOnSave
    autocmd!
    autocmd BufWritePre <buffer> call FormatCurrentBuffer()
augroup END

packadd ale
packadd lightline-ale
packadd vim-altr
packadd vim-cpp-enhanced-highlight

packadd vim-lsc
call RegisterLanguageServer('cpp', g:lsc_server_commands.cpp)
call lsc#config#mapKeys()

packadd echodoc.vim
call echodoc#enable()
