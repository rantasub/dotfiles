function! lspsupport#enable(language)
    let g:lsc_enable_autocomplete = v:false
    let g:lsc_auto_completeopt = v:false
    let g:lsc_enable_diagnostics = v:false
    let g:lsc_auto_map = {
        \ 'GoToDefinition': 'gd',
        \ 'FindImplementations': 'gD',
        \ 'FindReferences': 'gr',
        \ 'Rename': '<Leader>lr',
        \ 'DocumentSymbol': 'gs',
        \ 'WorkspaceSymbol': 'gS',
        \ 'FindCodeActions': '<Leader>la',
        \ 'ShowHover': v:true,
        \ 'Completion': 'omnifunc',
        \}
    packadd vim-lsc
    call RegisterLanguageServer(a:language, g:lsc_server_commands[a:language])
    call lsc#config#mapKeys()

    let g:ale_close_preview_on_insert = 1
    let g:ale_completion_enabled = 0
    let g:ale_echo_cursor = 1
    let g:ale_cursor_detail = 0
    let g:ale_echo_delay = 1000
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_linters_explicit = 1
    let g:ale_sign_error = '✘'
    let g:ale_sign_warning = '⚠'
    let g:ale_virtualtext_cursor = 0
    let g:ale_virtualtext_delay = 1000
    packadd ale
    packadd lightline-ale

    let g:echodoc#type = 'floating'
    packadd echodoc.vim
    call echodoc#enable()
endfunction
