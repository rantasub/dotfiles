if exists('b:ftplugin_after_loaded')
    finish
endif
let b:ftplugin_after_loaded = 1

let b:ale_linters = ['cmakelint']
let b:ale_cmake_cmakelint_executable = 'cmake-lint'
let b:ale_fix_on_save = 1
let b:ale_fixers = ['cmakeformat']

packadd ale
packadd lightline-ale
