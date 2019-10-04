if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

let g:ale_linters.python = ['pyflakes', 'pylint']
let g:lsc_server_commands.python = {
    \   'command': 'pyls',
    \   'name': 'python-language-server',
    \   'suppress_stderr': v:true,
    \   }
call lspsupport#enable('python')
