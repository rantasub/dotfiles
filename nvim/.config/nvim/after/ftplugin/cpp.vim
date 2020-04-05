if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

function! ClangFormatRange(firstLine, lastLine)
    let l:fileArg = shellescape(expand('%'))
    let l:command = printf('clang-format -style=file
                         \ -fallback-style=Microsoft
                         \ -assume-filename=%s -lines=%d:%d',
                         \ l:fileArg, a:firstLine, a:lastLine)

    let l:view = winsaveview()
    let l:formatted = system(l:command, getline(1, '$'))
    %delete _
    call setline(1, split(l:formatted, "\n", 1))
    call winrestview(l:view)
endfunction

function! ClangFormatExpr()
    call ClangFormatRange(v:lnum, v:lnum + v:count - 1)
endfunction

setlocal formatexpr=ClangFormatExpr()
setlocal foldcolumn=4

augroup AutoFormatOnSave
    autocmd! * <buffer>
    autocmd BufWritePre <buffer> call ClangFormatRange(1, line('$'))
augroup END

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
packadd vim-cpp-enhanced-highlight

let b:ale_linters = ['clangd']
let b:ale_c_build_dir_names = ['build']
let b:ale_c_build_dir = ''
let b:ale_c_parse_compile_commands = 1

let b:ale_cpp_clangd_executable = 'clangd'
let b:ale_cpp_clangd_options = '--background-index --clang-tidy '
                            \ .'--completion-style=detailed '
                            \ .'--header-insertion=never '
                            \ .'--header-insertion-decorators '
                            \ .'--suggest-missing-includes'
call lspsupport#enable()

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

packadd termdebug
