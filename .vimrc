call pathogen#infect()


"
" Configuraciones generales.
"

set nocompatible                " Cargar defaults de vim
let mapleader=","               " usar coma como <leader>
set history=1000                " aumentar history del redo/undo
set nobackup                    " que no haga backup de arhivos termporales
set directory=~/.vim/tmp        " directorio de archivos temporarios.
set autochdir
set noequalalways								"	que distintas ventanas puedan tener distintos tamaños.


"
" Colores
"


set t_Co=256    " usar 256 colores en la terminal.

let g:solarized_termcolors=256

set background=light
colorscheme solarized

" Cambiar entre dark/light de fondo para solarized
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

" Cambiar el color del cursor dependiento del tipo de ventana.
if &term =~ "xterm"
  let &t_SI = "\<Esc>]12;orange\x7"
  let &t_EI = "\<Esc>]12;gray\x7"
endif

"
" Configuración de la interfaz grafica
"

if has('gui_running')
  set guifont="Meslo LG M DZ"\ 10 " Fuente disponible en github.
  set lines=40
  set columns=120
  set guioptions-=m      " Sacar menu bar
  set guioptions-=T      " Sacar toolbar
  set guioptions+=LlRrb  " Sacar scroll de ambos lados
  set guioptions-=LlRrb
endif

"
" Tabs & Indentación
"

set autoindent    " copiar indentación de la linea anterior
set smartindent   " dependiendo de la sintaxis agregar un niver de indentación.
set tabstop=2
set shiftwidth=2

" shortcuts ',2' y ',4' para cambiar indentación rápido:
nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>


"
" Interface
"

set ls=2                            " Mostrar siempre la barra status
set ruler                           " Mostrar posicion del cursor
set number                          " mostrar lineas del documento
set notitle                         " Sacar titulo en modo no visual
set novisualbell                    " que no use la campana visual.
set wrap                            " wrap de lineas.
set showmatch                       " muestra el matcheo de (){}[]


set linebreak
set formatoptions=qrn1

" Mostrar los caracateres invisibles.
" Los mismos que textmate.

nmap <C-t-l> :set list!<CR>
set nolist
set listchars=tab:▸\ ,trail:·


set complete+=k

" para completar codigo en  XSL / CSS
set iskeyword+=-,:

" Redibujar pantalla
nmap <leader>r :redraw!<cr>



" Cambiar los colores de la barra de estado segun el modo
au InsertEnter * hi StatusLine ctermfg=226 ctermbg=16
au InsertLeave * hi StatusLine ctermfg=7 ctermfg=0

" Fomato de la statusline
set statusline=\ %F%m%r%h\ %w\ %{fugitive#statusline()}\ \Linea:\ %l/%L:%c

"
" Linea de comandos
"

set wildmenu                        " mejor completion
set wildmode=list:longest           " estilo BASH para completado
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,test/fixtures/*,vendor/gems/*
set completeopt=longest,menuone

" Ejecutar un archivo con nodejs <Shift><alt>+ e:
map <buffer><S-A-e> :w<CR>:!/usr/bin/env node % <CR>


" Cambiar automaticamente el directorio de trabajo al directorio donde esta el
" archivo
set autochdir

"
" Navegación & Viewport
"

set scrolloff=5       " por lo menos  5 lineas en el buffer cuando muevo el cursor
set sidescrolloff=5   " y 5 columnas de contenido.
set hidden                          " permite moverse entre buffers modificados (ocultos)
set backspace=indent,eol,start      " Mejora el comportamiento de la tecla backspace

" Set magic on, para las expresiones regulares.
set magic

"
" Copy/Paste
"

" copiar (en modo visual)
vmap <F7> "+ygv"zy`>
" Pegar (Shift-F7 para pegar después del cursor en modo normal, Ctrl-F7 para pegar sobre la selección visual.)
nmap <F7> "zgP
nmap <S-F7> "zgp
imap <F7> <C-r><C-o>z
vmap <C-F7> "zp`]
cmap <F7> <C-r><C-o>z

" Registrar copia (clipboard)
autocmd FocusGained * let @z=@+

" Solapas (movimiento y cerrado)
map <silent><A-Right> :tabnext<CR>
map <silent><A-Left> :tabprevious<CR>
map <silent><A-x> :tabclose<CR>
map <silent><A-o> :tabonly<CR>


" Habilitar Code Folding
set foldenable
set foldmethod=syntax


" mover solo lineas
" http://vimcasts.org/episodes/bubbling-text/
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Mover muchas lineas
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

set nolazyredraw " do not redraw while running macros (much faster) (LazyRedraw)
" set vb " blink instead beep



" Scrollear con mayor velocidad
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <C-j> 3j
nnoremap <C-k> 3k

"
" Caracteres
"

set encoding=utf-8

"
" Syntax & tipos de archivos
"

syntax enable                       " Habilitar colores para la sintxis
syntax on
filetype on           " Habilitar detección del archivo
filetype plugin on    " Activar plugins
filetype indent on    " Activar indentación (fucking neoanglosimo)

"
" Javascript
"
au FileType javascript setl fen
au FileType javascript setl nocindent

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType jade set omnifunc=jadecomplete#CompleteJade

autocmd Filetype Javascript set colorcolumn=81

" mostrar espacios en blanco con un color.
"
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Borrar espacios en blancos.
function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  if line("'Z") != line(".")
    echo "Stripped whitespace\n"
  endif
  normal `Z
endfunction
autocmd BufWritePre *.php,*.yml,*.xml,*.js,*.html,*.css :call StripTrailingWhitespace()

map <leader><F2> :call StripTrailingWhitespace()<CR>
map! <leader><F2> :call StripTrailingWhitespace()<CR>

"
" mapeo chanchero para trabajar con php (en modo insert)
"
imap jj ->
imap kk \
imap hh $this->

" Mostrar resaltado de busqueda y hacer wrap (acoplar) los resultados
set hls is " resaltar texto buscado
set wrapscan " hacer el wrap en texto buscado
set ic " ignorar myusculas/minusuclas



" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
"      Confiuración de plugins
"
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"
" Ctags
"

" Explorar tags para la palabra debajo del cursor
map <C-l> <C-]>

" Volver a la posicion inicial despues de buscar en los tags.
map <C-h> <C-T>

" Saltar al siguiente matched tag
map ]t :tnext<CR>

" Saltar al tag matcheado previamente.
map [t :tprevious<CR>

" Abrior tag (comando)
map <C-T> :tag
let g:Tlist_Ctags_Cmd = 'ctags'

" Reconstruir el indice de ctags.
nnoremap <silent> <C-F7> :silent !ctags -h ".php" --PHP-kinds=+cf --recurse --exclude="*/cache/*" --exclude="*/logs/*" --exclude="*/data/*" --exclude="\.git" --exclude="\.svn" --languages=PHP &<cr>:CommandTFlush<cr>

" lista de tags (taglist)
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
nnoremap <silent> <F9> :TlistToggle<CR>

"Delimitmate
au FileType * let b:delimitMate_autoclose = 1

" Coffeescript
au BufWritePost *.coffee silent CoffeeMake!

"
" Lusty
"

map <leader>lp :LustyBufferExplorer <cr>
let g:LustyJugglerShowKeys = 0

"
" Command-T
"
let g:CommandTMaxFiles=30000        " Aumentar tamaño cache (acelera un toque la busqueda)
map <leader>t :CommandT<cr>


"
" Snipmate
"

let g:snips_author = 'Antoine Hérault <antoine.herault@gmail.com>'

" Mostrar NERDTree (arbol con archivos del directorio de trabajo
map <F4> :NERDTreeToggle<CR>


" Tabularize  sirve para alinear el sigo igual o : en este caso.
nmap <Leader>ji :Tabularize /=<CR>
vmap <Leader>ji :Tabularize /=<CR>
nmap <Leader>jd :Tabularize /:\zs<CR>
vmap <Leader>jd :Tabularize /:\zs<CR>


" Autocomplete php
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

autocmd FileType c set tabstop=4
" Autocomplete coffee script
autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow

au Filetype php exec('set dictionary=~/.vim/syntax/ci-reactor-2.0.dict')
au Filetype php set complete+=k


" Configuración snipets para django
"
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate

"
" Funciones
"

" Indentar archivos. Usar plugin cuando el filetype es Javascript.
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

" Reindentar Codigo, borrar espacios en blanco y volver donde estaba la linea del cursor
nnoremap <silent> <leader>R :call IndentFile()<CR>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Borrar el simbolo ^M tipico de Windows -
noremap <Leader>mm mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Borrar el resaltado de la busqueda
nmap <leader><space> :noh<CR>


