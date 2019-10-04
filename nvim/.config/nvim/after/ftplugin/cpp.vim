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

packadd vim-altr
nnoremap <silent> <Leader>a :call altr#forward()<CR>
nnoremap <silent> <Leader>A :call altr#back()<CR>

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
packadd vim-cpp-enhanced-highlight

let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_clang_options = '-std=c++17 -Weverything'
let g:ale_cpp_clangtidy_checks = []
let g:ale_linters.cpp = ['clangd', 'clangtidy']
let g:lsc_server_commands.cpp = {
    \   'command': 'clangd -limit-results=0',
    \   'name': 'clangd',
    \   'suppress_stderr': v:true,
    \   }
call lspsupport#enable('cpp')

function! MakeCommandCompletion(ArgLead, CmdLine, CursorPos)
    let l:words = split(a:CmdLine)
    let l:words[0] = 'make'
    let l:command = join(l:words)
    return bash#complete(l:command)
endfunction

function! NinjaCommandCompletion(ArgLead, CmdLine, CursorPos)
    let l:words = split(a:CmdLine)
    let l:words[0] = 'ninja'
    let l:command = join(l:words)
    return bash#complete(l:command)
endfunction

command! -nargs=* -complete=customlist,MakeCommandCompletion Make AsyncRun -program=make @ <args>
command! -nargs=* -complete=customlist,NinjaCommandCompletion Ninja AsyncRun ninja <args>
