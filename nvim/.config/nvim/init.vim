set runtimepath+=/usr/share/vim/vimfiles
set runtimepath+=~/.cache/deinnvim/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/deinnvim')
 call dein#begin('~/.cache/deinnvim')
 call dein#add('~/.cache/deinnvim')

 call dein#add('w0rp/ale')
 call dein#add('skywind3000/asyncrun.vim')
 call dein#add('morhetz/gruvbox')
 call dein#add('wellle/targets.vim')
 call dein#add('tomtom/tcomment_vim')
 call dein#add('kana/vim-altr')
 call dein#add('Chiel92/vim-autoformat')
 call dein#add('ntpeters/vim-better-whitespace')
 call dein#add('octol/vim-cpp-enhanced-highlight')
 call dein#add('tpope/vim-fugitive')
 call dein#add('nathanaelkane/vim-indent-guides')
 call dein#add('lifepillar/vim-mucomplete')
 call dein#add('chaoren/vim-wordmotion')

 call dein#end()
 call dein#save_state()
endif

nnoremap <Space> <Nop>
let mapleader = "\<Space>"

filetype plugin indent on
syntax enable
set tabstop=4
set shiftwidth=4
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

set ignorecase
set smartcase
set incsearch
set hlsearch
set noshowmatch

let g:gruvbox_italic = 1
set background=dark
set termguicolors
colorscheme gruvbox

function! PrintCompletionMessage()
    unsilent echo 'Completion method: ' .get(g:mucomplete#msg#methods, g:mucomplete_current_method)
    let &readonly=&readonly " Force updating of the cursor
endfunction

function! FilterQuickfixListForCurrentBuffer()
    let l:qfListContent = getqflist()
    call filter(l:qfListContent, {idx, val -> val.bufnr == bufnr('%')})
    call setqflist(l:qfListContent)
endfunction

augroup CompletionMenu
 autocmd!
 autocmd User MUcompletePmenu call PrintCompletionMessage()
 autocmd CompleteDone * echo "\r"
augroup END

augroup FileTypeCpp
 autocmd!
 packadd vim-lsc
 autocmd BufWrite *.cpp,*.hpp,*.c,*.h :Autoformat
augroup END

augroup FileTypeQuickFix
 autocmd!
 autocmd FileType qf set nobuflisted
augroup END

nnoremap <silent> <Leader>ec :split $MYVIMRC<CR>
augroup VimRC
 autocmd!
 autocmd BufWritePost $MYVIMRC :source $MYVIMRC
augroup END

nnoremap <Up> <C-w>k
nnoremap <Down> <C-w>j
nnoremap <Left> <C-w>h
nnoremap <Right> <C-w>l

nnoremap <silent> <Leader>tc :MUcompleteAutoToggle<CR>
nnoremap <silent> <Leader>tf :call altr#forward()<CR>
nnoremap <silent> <Leader>tF :call altr#back()<CR>
nnoremap <silent> <Leader>ti :IndentGuidesToggle<CR>
nnoremap <silent> <Leader>tq :call asyncrun#quickfix_toggle(8)<CR>
nnoremap <silent> <Leader>tw :ToggleWhitespace<CR>

nnoremap <silent> <Leader>qq :call FilterQuickfixListForCurrentBuffer()<CR>

nnoremap <silent> <Leader>f :FZF<CR>

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

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

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1000
let g:mucomplete#always_use_completeopt = 1
let g:mucomplete#buffer_relative_paths = 1

let g:wordmotion_spaces = '_-.'

let g:ale_completion_enabled = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {'cpp':  ['clangd', 'clangtidy']}
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_clang_options = '-std=c++17 -Wall'
let g:ale_cpp_clangtidy_checks = []

let g:lsc_enable_autocomplete = v:false
let g:lsc_auto_completeopt = v:false
let g:lsc_enable_diagnostics = v:false
let g:lsc_server_commands = {
    \ 'cpp': {
    \   'command': 'clangd -limit-results=0',
    \   'name': 'clangd',
    \   'suppress_stderr': v:true,
    \   },
    \ }
let g:lsc_auto_map = {
    \ 'GoToDefinition': 'gd',
    \ 'FindImplementations': 'gD',
    \ 'FindReferences': 'gr',
    \ 'Rename': 'gR',
    \ 'DocumentSymbol': 'gS',
    \ 'WorkspaceSymbol': 'gs',
    \ 'FindCodeActions': 'ga',
    \ 'ShowHover': v:true,
    \ 'Completion': 'omnifunc',
    \}

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

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
