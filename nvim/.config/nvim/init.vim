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

set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

set mouse=n
set mousemodel=popup

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set colorcolumn=80
set scrolloff=10
set number
set cursorline
set hidden
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noselect
set shortmess=tc
set noshowmode
set signcolumn=auto:4

set showbreak=↪\ 
set list
set listchars=tab:▸\ ,trail:•,precedes:←,extends:→,nbsp:␣

set foldmethod=syntax
set foldlevelstart=99

set ignorecase
set smartcase
set inccommand=split
set incsearch
set nohlsearch
set noshowmatch

set splitright

let g:gruvbox_italic = 1
set background=dark
set termguicolors
colorscheme gruvbox

highlight ActiveWindow guibg=#282828
highlight InactiveWindow guibg=#2D2D2D

let g:asyncrun_open = 8
let g:asyncrun_save = 2

let g:neoterm_automap_keys = '<Leader>rr'
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoscroll = 1

let g:wordmotion_spaces = '_-.'

function! FilterQuickfixListForCurrentBuffer()
    let l:qfListContent = getqflist()
    call filter(l:qfListContent, {idx, val -> val.bufnr == bufnr('%')})
    call setqflist(l:qfListContent)
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

function! s:getProjectionsFile(fname)
    let l:cwd = fnamemodify(a:fname, ':p')
    let l:projectionsFile = fnamemodify('~', ':p') .'.config/projections/'
        \ .fnamemodify(l:cwd, ':h:t') .'/projections.json'

    return l:projectionsFile
endfunction

function! s:LoadProjections()
    let l:cwd = fnamemodify('.', ':p')
    let l:projectionsFile = s:getProjectionsFile('.')
    if filereadable(l:projectionsFile)
        call projectionist#append(l:cwd,
            \ json_decode(readfile(l:projectionsFile)))
    endif
endfunction

function! s:HandleProjectSettings()
    if !exists('g:loaded_projectionist') &&
        \ filereadable(s:getProjectionsFile('<afile>'))
        packadd vim-projectionist
        call ProjectionistDetect(expand('<afile>:p'))
    endif
endfunction

augroup ProjectSettings
    autocmd!
    autocmd BufReadPost * call s:HandleProjectSettings()
    autocmd User ProjectionistDetect call s:LoadProjections()
augroup END

augroup WindowManagement
    autocmd!
    autocmd WinEnter * call HandleWinEnter()
augroup END

augroup FileTypeQuickFix
 autocmd!
 autocmd FileType qf set nobuflisted
augroup END

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

nnoremap <silent> <Leader>ecc :split $MYVIMRC<CR>
nnoremap <silent> <Leader>ecf :EditFileTypePlugin<CR>

nnoremap <silent> <Leader>tq :call asyncrun#quickfix_toggle(8)<CR>

nnoremap <silent> <Leader>qq :call FilterQuickfixListForCurrentBuffer()<CR>

nnoremap <silent> <Leader>f :Fd<CR>
nnoremap <silent> g* :execute(':RgFileType ' .expand('<cword>'))<CR>

tnoremap <Esc> <C-\><C-n>

command! -nargs=? -complete=filetype EditFileTypePlugin
    \ execute 'edit ' .stdpath('config') .'/after/ftplugin/'
    \ .(empty(<q-args>) ? &filetype : <q-args>) .'.vim'
command! -bang -nargs=0 Fd call fzf#run(fzf#wrap(
    \ 'fd', {'source': 'fd', 'sink': 'edit'}, <bang>0))
command! -bang -nargs=1 Rg call fzf#run(fzf#wrap(
    \ 'ripgrep', {'source': 'rg --vimgrep <args>', 
    \ 'sink': function('HandleRipGrep')}, <bang>0))
command! -bang -nargs=1 RgFileType call fzf#run(fzf#wrap(
    \ 'ripgrep_filetype', {'source': 'rg --vimgrep --type '. &filetype .' <args>', 
    \ 'sink': function('HandleRipGrep')}, <bang>0))

cabbrev <expr> %% expand('%:p:h')

packadd vim-textobj-user
packadd vim-textobj-entire
packadd vim-indent-object

packadd plenary.nvim
packadd null-ls.nvim
packadd nvim-lspconfig
packadd sekme.nvim

lua << EOF
require('mylspconfig')
EOF
