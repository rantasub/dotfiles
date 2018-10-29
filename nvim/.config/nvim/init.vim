set runtimepath+=~/.cache/deinnvim/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/deinnvim')
 call dein#begin('~/.cache/deinnvim')
 call dein#add('~/.cache/deinnvim')

 call dein#add('w0rp/ale')
 call dein#add('skywind3000/asyncrun.vim')
 call dein#add('Shougo/denite.nvim')
 call dein#add('morhetz/gruvbox')
 call dein#add('sjl/gundo.vim')
 call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })
 call dein#add('scrooloose/nerdtree')
 call dein#add('sakhnik/nvim-gdb')
 call dein#add('majutsushi/tagbar')
 call dein#add('wellle/targets.vim')
 call dein#add('tomtom/tcomment_vim')
 call dein#add('vim-airline/vim-airline')
 call dein#add('kana/vim-altr')
 call dein#add('Chiel92/vim-autoformat')
 call dein#add('ntpeters/vim-better-whitespace')
 call dein#add('Squareys/vim-cmake')
 call dein#add('octol/vim-cpp-enhanced-highlight')
 call dein#add('easymotion/vim-easymotion')
 call dein#add('tpope/vim-fugitive')
 call dein#add('nathanaelkane/vim-indent-guides')
 call dein#add('lifepillar/vim-mucomplete')
 call dein#add('janko-m/vim-test')
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

set ignorecase
set smartcase
set incsearch
set hlsearch
set noshowmatch

let g:gruvbox_italic = 1
set background=dark
set termguicolors
colorscheme gruvbox

augroup FileTypeCpp
 autocmd!
 autocmd BufWrite *.cpp,*.hpp,*.c,*.h :Autoformat

 autocmd FileType cpp nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
 autocmd FileType cpp nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
 autocmd FileType cpp nnoremap <buffer> <silent> <Leader>lr :call LanguageClient#textDocument_rename()<CR>
 autocmd FileType cpp nnoremap <buffer> <silent> <Leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
 autocmd FileType cpp nnoremap <buffer> <silent> <Leader>lx :call LanguageClient#textDocument_references()<CR>
 autocmd FileType cpp nnoremap <buffer> <silent> <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
 autocmd FileType cpp nnoremap <buffer> <silent> <Leader>lS :call LanguageClient#workspace_symbol()<CR>
 autocmd FileType cpp nnoremap <buffer> <silent> <Leader>lm :call LanguageClient_contextMenu()<CR>
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

nnoremap <silent> <Leader>tb :NERDTreeToggle<CR>
nnoremap <silent> <Leader>tc :MUcompleteAutoToggle<CR>
nnoremap <silent> <Leader>tf :call altr#forward()<CR>
nnoremap <silent> <Leader>tF :call altr#back()<CR>
nnoremap <silent> <Leader>ti :IndentGuidesToggle<CR>
nnoremap <silent> <Leader>tq :call asyncrun#quickfix_toggle(8)<CR>
nnoremap <silent> <Leader>tt :TagbarToggle<CR>
nnoremap <silent> <Leader>tu :GundoToggle<CR>
nnoremap <silent> <Leader>tw :ToggleWhitespace<CR>

nnoremap <silent> <Leader>f :Denite file/rec<CR>
nnoremap <silent> <Leader>b :Denite buffer<CR>
nnoremap <silent> <Leader>g :Denite grep<CR>
nnoremap <silent> <Leader>h :Denite help<CR>
nnoremap <silent> <Leader>? :Denite command<CR>

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#ale#enabled = 1

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

let g:deoplete#enable_at_startup = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1000
let g:mucomplete#always_use_completeopt = 1
let g:mucomplete#buffer_relative_paths = 1

let g:nvimgdb_disable_start_keymaps = 1
" g:nvimgdb_key_until
" g:nvimgdb_key_continue
" g:nvimgdb_key_next
" g:nvimgdb_key_step
" g:nvimgdb_key_finish
" g:nvimgdb_key_breakpoint
" g:nvimgdb_key_frameup
" g:nvimgdb_key_framedown
" g:nvimgdb_key_eval

let g:wordmotion_spaces = '_-.'

let g:ale_completion_enabled = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {'cpp':  ['clang', 'clangtidy']}
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_cquery_cache_directory = '/tmp/cquery'
let g:ale_cpp_clangtidy_checks = ['*', '-fuchsia-default-arguments', '-clang-diagnostic-c++98-compat-*']

let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile = '/tmp/LanguageClient-neovim.log'
let g:LanguageClient_serverStderr = '/tmp/LanguageClient-neovim-serverstderr.log'
let g:LanguageClient_selectionUI = 'quickfix'
let g:LanguageClient_hoverPreview = 'Never'
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_diagnosticsSignsMax = 500
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd', '-use-dex-index', '-index', '-index-file=changeme_location_clangd.dex', '-log=verbose', '-limit-results=0'],
  \ }

call denite#custom#var('file/rec', 'command',
	\ ['rg', '--files', '--glob', '!.git'])

call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#map(
	      \ 'insert',
	      \ '<Down>',
	      \ '<denite:move_to_next_line>',
	      \ 'noremap'
	      \)
call denite#custom#map(
	      \ 'insert',
	      \ '<Up>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
          \)
