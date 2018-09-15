set runtimepath+=~/.cache/deinnvim/repos/github.com/Shougo/dein.vim

let mapleader = "\<Space>"

if dein#load_state('~/.cache/deinnvim')
 call dein#begin('~/.cache/deinnvim')
 call dein#add('~/.cache/deinnvim')

 call dein#add('w0rp/ale')
 call dein#add('skywind3000/asyncrun.vim')
 call dein#add('Shougo/deoplete.nvim')
 call dein#add('Shougo/denite.nvim')
 call dein#add('morhetz/gruvbox')
 call dein#add('sjl/gundo.vim')
 call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })
 call dein#add('scrooloose/nerdtree')
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
 call dein#add('nathanaelkane/vim-indent-guides')
 call dein#add('janko-m/vim-test')
 call dein#add('chaoren/vim-wordmotion')

 call dein#end()
 call dein#save_state()
endif

autocmd! BufWrite *.cpp,*.hpp,*.c,*.h :Autoformat

let g:deoplete#enable_at_startup = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:better_whitespace_enabled= 1

nnoremap <silent> <Leader>ec :split $MYVIMRC<CR>
autocmd! BufWritePost $MYVIMRC :source $MYVIMRC

nnoremap <silent> <Leader>tf :call altr#forward()<CR>
nnoremap <silent> <Leader>tF :call altr#back()<CR>
nnoremap <silent> <Leader>ti :IndentGuidesToggle<CR>
nnoremap <silent> <Leader>tt :TagbarToggle<CR>
nnoremap <silent> <Leader>tu :GundoToggle<CR>
nnoremap <silent> <Leader>tw :ToggleWhitespace<CR>

let g:ale_completion_enabled = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {'cpp':  ['clang', 'clangtidy']}
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_cquery_cache_directory = '/tmp/cquery'
let g:ale_cpp_clangtidy_checks = ['*', '-fuchsia-default-arguments', '-clang-diagnostic-c++98-compat-*']
let g:airline#extensions#ale#enabled = 1

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_diagnosticsSignsMax = 500
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {
	\ 'cpp' : ['cquery', '--log-file=/tmp/LanguageClientNeovimCquery.log', "--init={\"cacheDirectory\": \"/tmp/cquery\"}"],
	\ }
nnoremap <silent> <Leader>lc :call LanguageClient#cquery_callers()<CR>
nnoremap <silent> <Leader>lr :call LanguageClient_textDocument_rename()<CR>
"LanguageClient#cquery_vars(...)
"LanguageClient#cquery_derived(...)
"LanguageClient#cquery_base(...)

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <F6> :Denite documentSymbol<CR>
nnoremap <silent> <F7> :Denite references<CR>
nnoremap <silent> <F8> :Denite workspaceSymbol<CR>
"anguageClient_textDocument_typeDefinition()
"LanguageClient_textDocument_implementation()
"LanguageClient_textDocument_codeAction()
"LanguageClient_workspace_applyEdit()
"LanguageClient_workspace_executeCommand()

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

call denite#custom#var('file/rec', 'command',
	\ ['rg', '--files', '--glob', '!.git'])

" Ripgrep command on grep source
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

let s:menus = {}

let s:menus.files = {
	\ 'description': 'Files'
	\ }

let s:menus.files.command_candidates = [
	\ ['Toggle file browser', 'NERDTreeToggle'],
	\ ['Search', 'Denite file/rec'],
	\]

call denite#custom#var('menu', 'menus', s:menus)

nnoremap <silent> <Leader>m :Denite menu<CR>
nnoremap <silent> <Leader>fb :NERDTreeToggle<CR>
nnoremap <silent> <Leader>fs :Denite file/rec<CR>
nnoremap <silent> <Leader>b :Denite buffer<CR>
nnoremap <silent> <Leader>g :Denite grep<CR>
nnoremap <silent> <Leader>h :Denite help<CR>
nnoremap <silent> <Leader>? :Denite command<CR>

let g:wordmotion_spaces = '_-.'

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:gruvbox_italic=1
set background=dark
set termguicolors
colorscheme gruvbox

set number relativenumber
set cursorline
set hidden
set wildmenu
set wildmode=longest:full,full

set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch
set showmatch

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set colorcolumn=80
set scrolloff=10
syntax enable
