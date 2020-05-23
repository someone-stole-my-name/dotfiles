"Copy/Paste with C-c/C-v (Linux)
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
noremap  <C-v> :r !xclip -o -sel c<CR><CR>

"Reload vimrc and install plugins
noremap <C-r> :source ~/.vimrc<CR><CR>:PlugI<CR><CR>

command JSONpretty execute '%!python -m json.tool' | w

"Line numbers
set number

" Not really necesary if using vimrc
set nocompatible

"Set encoding
set encoding=UTF-8

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

call plug#begin('~/.vim/plugged')
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-sensible'
Plug 'conradirwin/vim-bracketed-paste'
Plug 'christoomey/vim-tmux-navigator'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdcommenter'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'hashivim/vim-terraform'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'b4b4r07/vim-ansible-vault'
Plug 'ryanoasis/vim-devicons'
call plug#end()

"Set colorscheme
colorscheme nord

"Use grip
let vim_markdown_preview_github=1

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_aggregate_errors         = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 0
let g:syntastic_check_on_wq              = 1
let g:syntastic_ansible_checkers         = ['ansible_lint']
au BufRead,BufNewFile ~/git/semaas-operations/ansible/* set filetype=yaml.ansible
au BufRead,BufNewFile ~/git/blackops/**.yml set filetype=yaml.ansible
au BufRead,BufNewFile ~/git/blackops/**.yaml set filetype=yaml.ansible

"Use powerline fonts in airline
let g:airline_powerline_fonts = 1

"LSP
let g:lsp_diagnostics_enabled          = 1
let g:lsp_signs_enabled                = 1
let g:lsp_diagnostics_echo_cursor      = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': '??'}

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:terraform_fmt_on_save=1
let g:terraform_align=1


let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/asyncomplete.log')
