if exists('b:ftpluginAfterLoaded')
    finish
endif
let b:ftpluginAfterLoaded = 1

packadd ale
packadd lightline-ale
packadd vim-altr
packadd vim-cpp-enhanced-highlight

packadd vim-lsc
call RegisterLanguageServer('cpp', g:lsc_server_commands.cpp)
call lsc#config#mapKeys()

packadd vim-autoformat
augroup AutoFormatOnSave
    autocmd!
    autocmd BufWrite <buffer> :Autoformat
augroup END

packadd echodoc.vim
call echodoc#enable()
