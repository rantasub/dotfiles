set runtimepath+=/usr/share/vim/vimfiles

nnoremap <Space> <Nop>
let mapleader = "\<Space>"

filetype on
filetype plugin on
filetype indent on
syntax enable

set swapfile
set writebackup
set nobackup
set backupcopy=auto
set undofile

set diffopt=filler,internal,algorithm:patience

set mouse=n
set mousemodel=popup

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set colorcolumn=80
set scrolloff=10
set number relativenumber
set cursorline
set hidden
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noselect
set shortmess=c
set noshowmode
set signcolumn=auto:4

set ignorecase
set smartcase
set incsearch
set hlsearch
set noshowmatch

let g:gruvbox_italic = 1
set background=dark
set termguicolors
colorscheme gruvbox

highlight ActiveWindow guibg=#282828
highlight InactiveWindow guibg=#2D2D2D

let g:asyncrun_open = 8
let g:asyncrun_save = 2
let g:asyncrun_last = 1
let g:asyncrun_timer = 1000

let g:better_whitespace_enabled = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline.component_expand = {
    \ 'linter_checking': 'lightline#ale#checking',
    \ 'linter_warnings': 'lightline#ale#warnings',
    \ 'linter_errors': 'lightline#ale#errors',
    \ 'linter_ok': 'lightline#ale#ok',
    \ }
let g:lightline.active = {
    \ 'right': [[
    \   'linter_checking',
    \   'linter_errors',
    \   'linter_warnings',
    \   'linter_ok',
    \   ]],
    \ }
let g:lightline.component_type = {
    \ 'linter_checking': 'left',
    \ 'linter_warnings': 'warning',
    \ 'linter_errors': 'error',
    \ 'linter_ok': 'left',
    \ }

let g:mucomplete#enable_auto_at_startup = 0
let g:mucomplete#completion_delay = 1000
let g:mucomplete#always_use_completeopt = 1
let g:mucomplete#buffer_relative_paths = 1

let g:wordmotion_spaces = '_-.'

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
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_clang_options = '-std=c++17 -Wall'
let g:ale_cpp_clangtidy_checks = []
let g:ale_linters = {
    \ 'cpp':  ['clangd', 'clangtidy'],
    \ 'python': ['pyflakes', 'pylint'],
    \ }

let g:lsc_enable_autocomplete = v:false
let g:lsc_auto_completeopt = v:false
let g:lsc_enable_diagnostics = v:false
let g:lsc_server_commands = {
    \ 'cpp': {
    \   'command': 'clangd -limit-results=0',
    \   'name': 'clangd',
    \   'suppress_stderr': v:true,
    \   },
    \ 'python': {
    \   'command': 'pyls',
    \   'name': 'python-language-server',
    \   'suppress_stderr': v:true,
    \   },
    \ }
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

let g:echodoc#type = 'floating'

let g:fzf_colors = {
	\ 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'],
	\ }

function! PrintCompletionMessage()
    unsilent echo 'Completion method: ' .get(g:mucomplete#msg#methods, g:mucomplete_current_method)
    let &readonly=&readonly " Force updating of the cursor
endfunction

function! FilterQuickfixListForCurrentBuffer()
    let l:qfListContent = getqflist()
    call filter(l:qfListContent, {idx, val -> val.bufnr == bufnr('%')})
    call setqflist(l:qfListContent)
endfunction

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

function! HandleRipGrep(Output)
    let l:split = split(a:Output, ':')
    let l:filename = l:split[0]
    let l:row = l:split[1]
    let l:column = l:split[2]
    execute('edit +call\ cursor(' .l:row .',' .l:column .') ' .l:filename)
endfunction

function! HandleWinEnter()
    setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

augroup WindowManagement
    autocmd!
    autocmd WinEnter * call HandleWinEnter()
augroup END

augroup CompletionMenu
 autocmd!
 autocmd User MUcompletePmenu call PrintCompletionMessage()
 autocmd CompleteDone * echo "\r"
augroup END

augroup FileTypeCpp
 autocmd!
 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h packadd ale
 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h packadd lightline-ale
 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h packadd vim-altr
 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h packadd vim-autoformat
 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h packadd vim-cpp-enhanced-highlight
 autocmd BufWrite *.cpp,*.hpp,*.c,*.h :Autoformat

 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h packadd vim-lsc
 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h call
    \ RegisterLanguageServer('cpp', g:lsc_server_commands.cpp)

 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h packadd echodoc.vim
 autocmd BufReadPre,FileReadPre *.cpp,*.hpp,*.c,*.h call echodoc#enable()
augroup END

augroup FileTypeQuickFix
 autocmd!
 autocmd FileType qf set nobuflisted
augroup END

nnoremap <silent> <Leader>ec :split $MYVIMRC<CR>
nnoremap <silent> <Leader>eC :edit $MYVIMRC<CR>
augroup VimRC
 autocmd!
 autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

nmap <Leader>n ]
nmap <Leader>N [
nmap <Leader>p [
omap <Leader>n ]
omap <Leader>N [
omap <Leader>p [
xmap <Leader>n ]
xmap <Leader>N [
xmap <Leader>p [

nnoremap <Up> <C-w>k
nnoremap <Down> <C-w>j
nnoremap <Left> <C-w>h
nnoremap <Right> <C-w>l

nnoremap <Leader>1 :diffget LOCAL<CR>
nnoremap <Leader>2 :diffget BASE<CR>
nnoremap <Leader>3 :diffget REMOTE<CR>

nnoremap <silent> <Leader>tc :MUcompleteAutoToggle<CR>
nnoremap <silent> <Leader>tf :call altr#forward()<CR>
nnoremap <silent> <Leader>tF :call altr#back()<CR>
nnoremap <silent> <Leader>ti :IndentGuidesToggle<CR>
nnoremap <silent> <Leader>tq :call asyncrun#quickfix_toggle(8)<CR>
nnoremap <silent> <Leader>tw :ToggleWhitespace<CR>

nnoremap <silent> <Leader>qq :call FilterQuickfixListForCurrentBuffer()<CR>

nnoremap <silent> <Leader>f :Fd<CR>
nnoremap <silent> g* :execute(':RgFileType ' .expand('<cword>'))<CR>

tnoremap <A-e> <C-\><C-n>

command! -nargs=* -complete=customlist,MakeCommandCompletion Make AsyncRun -program=make @ <args>
command! -nargs=* -complete=customlist,NinjaCommandCompletion Ninja AsyncRun ninja <args>

command! -bang -nargs=0 Fd call fzf#run(fzf#wrap(
    \ 'fd', {'source': 'fd', 'sink': 'edit'}, <bang>0))
command! -bang -nargs=1 Rg call fzf#run(fzf#wrap(
    \ 'ripgrep', {'source': 'rg --vimgrep <args>', 
    \ 'sink': function('HandleRipGrep')}, <bang>0))
command! -bang -nargs=1 RgFileType call fzf#run(fzf#wrap(
    \ 'ripgrep_filetype', {'source': 'rg --vimgrep --type '. &filetype .' <args>', 
    \ 'sink': function('HandleRipGrep')}, <bang>0))

cabbrev <expr> %% expand('%:p:h')
