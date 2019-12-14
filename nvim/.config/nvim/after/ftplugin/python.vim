if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

let g:ale_linters.python = ['pyflakes', 'pylint']

let b:ale_fix_on_save = 1
let b:ale_fixers = ['black']

let g:lsc_server_commands.python = {
    \   'command': 'pyls',
    \   'name': 'python-language-server',
    \   'suppress_stderr': v:true,
    \   }
call lspsupport#enable('python')

let test#strategy = 'neovim'
let test#neovim#term_position = 'belowright'
packadd vim-test
