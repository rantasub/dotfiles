function! lspsupport#enable()
    let g:ale_close_preview_on_insert = 1
    let g:ale_completion_enabled = 0
    let g:ale_cursor_detail = 0
    let g:ale_echo_cursor = 0
    let g:ale_echo_delay = 500
    let g:ale_echo_msg_format = '[%linter% (%severity%)] %s'
    let g:ale_linters_explicit = 1
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = '⚠'
    let g:ale_virtualtext_cursor = 1
    let g:ale_virtualtext_delay = 500

    packadd ale

    setlocal omnifunc=ale#completion#OmniFunc
    nnoremap <buffer> <silent> gd :ALEGoToDefinition<CR>
    nnoremap <buffer> <silent> gD :ALEGoToTypeDefinition<CR>
    nnoremap <buffer> <silent> gr :ALEFindReferences<CR>
    nnoremap <buffer> <silent> K :ALEHover<CR>
    nnoremap <buffer> <silent> gs :execute(':ALESymbolSearch ' .expand('<cword>'))<CR>
    nnoremap <buffer> <silent> <Leader>lr :ALERename<CR>
    nnoremap <buffer> <silent> <Leader>ll :ALEDetail<CR>
    nnoremap <buffer> <Leader>ls :ALESymbolSearch<Space>

    let g:echodoc#type = 'floating'
    packadd echodoc.vim
    call echodoc#enable()
endfunction
