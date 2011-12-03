call pathogen#infect()


"
" General behavior
"

set nocompatible                " Use vim defaults
let mapleader=","               " Use the comma as leader
set history=1000                " Increase history
set nobackup                    " Do not backup files on overwrite
set directory=~/.vim/tmp        " Directory to put swap file
set autochdir
"" not let all windows keep the same height/width
set noequalalways


"
" Coloration
"


set t_Co=256    " use 256 colors
"colorscheme jellybeans



let g:solarized_termcolors=256


"set background='dark'

colorscheme solarized

set background=light
" Toggle dark/light background for solarized
nmap <leader>tb :call ToggleSolarized()<CR>
function! ToggleSolarized()
  if &background == "dark"
    colorscheme solarized
    set background=light
    if &term =~ "xterm"
      let &t_SI = "\<Esc>]12;orange\x7"
      let &t_EI = "\<Esc>]12;gray\x7"
    endif

  else
    colorscheme solarized
    set background=dark
    if &term =~ "xterm"
      let &t_SI = "\<Esc>]12;orange\x7"
      let &t_EI = "\<Esc>]12;white\x7"
    endif
  endif
endfunc


if has('gui_running')
  set guifont=Monospace\ 10 " default monospace font
  set lines=40
  set columns=120
  set guioptions-=m      " Remove menu bar
  set guioptions-=T      " Remove toolbar
  set guioptions+=LlRrb  " Sacar scroll de ambos lados
  set guioptions-=LlRrb
  "    set guioptions+=lrb " Add/Remove right-hand scroll bar
  "    set guioptions-=lrb " Add/Remove right-hand scroll bar
  "    set guioptions-=l " Remove left-hand scroll bar

endif

"
" Tabs & Indentation
"

" set expandtab     " converts tabs to spaces
set autoindent    " automatically copy indentation from previous line
set smartindent   " indents one extra level according to current syntax
" indents with tab = 4 spaces
set tabstop=2
set shiftwidth=2
" fixme: should use softtabstop=4 instead of expandtab and setting tabstop

" define shortcuts ',2' and ',4' to change indentation easily:
nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>
"
" Interface
"

set ls=2                            " Always show the status line
set ruler                           " Show cursor position
set number                          " Show line numbers
set notitle                         " Don't show title in console title bar
set novisualbell                    " Don't use the visual bell
set wrap                            " Wrap lineource $MYVIMRC
set showmatch                       " Show matching (){}[]
" set showbreak=...
set linebreak
set formatoptions=qrn1

" Display invisible characters.
" " Use the same symbols as TextMate for tabstops and EOLs

nmap <leader>tl :set list!<CR>
set nolist
set listchars=tab:▸\ ,eol:¬,trail:·,extends:↷,precedes:↶
" set list
" \\·

"" Disable AutoClose plugin on markdown files"
"autocmd FileType * :AutoCloseOn
"autocmd FileType markdown :AutoCloseOff
"autocmd FileType markdown :set spell


"set listchars=eol:?,tab:>-,trail:~,extends:>,precedes:<

set complete+=k
" for XSL / CSS - completition works great
set iskeyword+=-,:

" Redraw screen
nmap <leader>r :redraw!<cr>

" Clear search highlight
" nmap <silent> <leader>/ :let @/=""<cr>

" Change cursor color depending on the mode
if &term =~ "xterm"
  let &t_SI = "\<Esc>]12;orange\x7"
  let &t_EI = "\<Esc>]12;gray\x7"
endif

" Change statusbar color depending on the mode
au InsertEnter * hi StatusLine ctermfg=226 ctermbg=16
au InsertLeave * hi StatusLine ctermfg=7 ctermfg=0

"
" Command line
"

set wildmenu                        " Better completion
set wildmode=list:longest           " BASH style completion
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*


"Set magic on, for regular expressions
set magic



"
" Navigation & Viewport
"

set scrolloff=5       " at least 5 lines of context when moving cursor
set sidescrolloff=5   " and 5 columns of contet
set hidden                          " Allow switch beetween modified buffers
set backspace=indent,eol,start      " Improve backspacing

"copy
vmap <F7> "+ygv"zy`>
"paste (Shift-F7 to paste after normal cursor, Ctrl-F7 to paste over visual selection)
nmap <F7> "zgP
nmap <S-F7> "zgp
imap <F7> <C-r><C-o>z
vmap <C-F7> "zp`]
cmap <F7> <C-r><C-o>z
"copy register

autocmd FocusGained * let @z=@+

" tabbing
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>
map <silent><A-x> :tabclose<CR>
map <silent><A-o> :tabonly<CR>
" Enable Code Folding
set foldenable
set foldmethod=syntax


"http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone

"Bubble single lines (kicks butt)
"http://vimcasts.org/episodes/bubbling-text/
nmap <C-Up> ddkP
nmap <C-Down> ddp

"Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" set lazyredraw " do not redraw while running macros (much faster) (LazyRedraw)
" set vb " blink instead beep



" Faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <C-j> 3j
nnoremap <C-k> 3k

"
" Chars
"

set encoding=utf-8

"
" Syntax & File types
"

syntax enable                       " Enable syntax highlighting
syntax on
filetype on           " enable file type detection
filetype plugin on    " load plugins specific to file type
filetype indent on    " ... and indentation too

" Use the htmljinja syntax for twig files
au BufNewFile,BufRead *.twig setf htmljinja

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" automatically remove trailing whitespace before write
function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  if line("'Z") != line(".")
    echo "Stripped whitespace\n"
  endif
  normal `Z
endfunction
autocmd BufWritePre *.php,*.yml,*.xml,*.js,*.html,*.css :call StripTrailingWhitespace()

map <F2> :call StripTrailingWhitespace()<CR>
map! <F2> :call StripTrailingWhitespace()<CR>

"
" Some sugar on my Keyboard
"

" in insert mode (imap), some useful shortcuts.
imap jj ->
imap kk \
imap hh $this->

"Set Search options highlight, and wrap search
set hls is " highlight search text throughout the document.
set wrapscan " wrap the scan around the document
set ic "ignore case in search

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
"      PLUGINS CONFIGURATION
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




" Load bundles help & code
" silent! call pathogen#helptabs()
" silent! call pathogen#runtime_append_all_bundles()

"
" Ctags
"

" Explore tags for the word under the cursor
map <C-l> <C-]>
" Back to previous location after browsing tags
map <C-h> <C-T>
" Jump to next tag match
map ]t :tnext<CR>
" Jump to previous tag match
map [t :tprevious<CR>
" Open tag command
map <C-T> :tag
let g:Tlist_Ctags_Cmd = 'ctags'
" Rebuild tag index
nnoremap <silent> <C-F7> :silent !ctags -h ".php" --PHP-kinds=+cf --recurse --exclude="*/cache/*" --exclude="*/logs/*" --exclude="*/data/*" --exclude="\.git" --exclude="\.svn" --languages=PHP &<cr>:CommandTFlush<cr>
" TagList
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
nnoremap <silent> <F9> :TlistToggle<CR>

"Delimitmate
au FileType * let b:delimitMate_autoclose = 1


"
" Lusty
"

" map <leader>lp :LustyJugglePrevious<cr>
map <leader>lp :LustyBufferExplorer <cr>
let g:LustyJugglerShowKeys = 0

"
" Command-T
"

let g:CommandTMaxFiles=30000        " Increase cache size
map <leader>t :CommandT<cr>

"
" Ack
"

" let g:ackprg = 'ack-grep -H --nocolor --nogroup --column --type-add html=twig --ignore-dir=cache --ignore-dir=logs'
" nmap <leader>a :Ack

"
" Snipmate
"

let g:snips_author = 'Antoine Hérault <antoine.herault@gmail.com>'

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType jade set omnifunc=jadecomplete#CompleteJade

" toggle NERDTree
map <F4> :NERDTreeToggle<CR>

" Ejecutar un archivo con nodejs <Shift> + e:
map <buffer><S-E> :w<CR>:!/usr/bin/env node % <CR>

" Tabularize
" if exists(":Tabularize")
nmap <Leader>ji :Tabularize /=<CR>
vmap <Leader>ji :Tabularize /=<CR>
nmap <Leader>jd :Tabularize /:\zs<CR>
vmap <Leader>jd :Tabularize /:\zs<CR>
" endif


" autocomplete php
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

"autocomplete coffee script
autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow

au Filetype php exec('set dictionary=~/.vim/syntax/ci-reactor-2.0.dict')
au Filetype php set complete+=k


" config snipets para django
"
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate

"" Disable AutoClose plugin on markdown files"
"autocmd FileType * :AutoCloseOn
"autocmd FileType markdown :AutoCloseOff
"autocmd FileType markdown :set spell

"Funciones
"
"" Indent files. Use plugin when filetype is Javascript.
function! IndentFile()
  if &filetype == 'javascript'
    let l = line('.')
    let c = col('.')
    call g:Jsbeautify()
    call cursor(l,c)
  else
    let l = line('.')
    let c = col('.')
    execute "normal! gg=G"
    call cursor(l,c)
  endif
endfunction

" Reindent Code, strip trailing whitespace and go back to the line the cursor
" was
nnoremap <silent> <leader>R :call IndentFile()<CR>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>mm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"" Clear search highlight
" nnoremap <leader><space> :noh<CR>

"" Automatically change working dir to current buffer
set autochdir
