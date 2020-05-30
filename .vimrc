map <Space> <Leader>
"Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

"Move between tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

"Copy/Paste with C-c/C-v (Linux)
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
noremap  <C-v> :r !xclip -o -sel c<CR><CR>

"Reload vimrc and install plugins
noremap <C-r> :source ~/.vimrc<CR><CR>:PlugI<CR><CR>

command JSONpretty execute '%!python -m json.tool' | w

"Line numbers
set number

"Forgive me Lord for i have sinned
set mouse=a

"Set current directory to buffer file
autocmd BufEnter * silent! lcd %:p:h

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
Plug 'bronson/vim-trailing-whitespace'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'hashivim/vim-terraform'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'someone-stole-my-name/vim-ansible-vault'
Plug 'ryanoasis/vim-devicons'
call plug#end()

map <silent> <C-o> :NERDTreeToggle<CR>

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

"Close NERDTree when is is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif
