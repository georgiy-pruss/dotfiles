" _vimrc 2010 Georgiy Pruss
" ~~~~~~~~~~~~~~~~~~~~~~~~~


"*** SETTINGS ***

set nocompatible

source $VIMRUNTIME/mswin.vim
set winaltkeys=no
" behave mswin -- already in mswin.vim
" backspace and cursor keys wrap to previous/next line
" CTRL-A is Select all (was Increment, remapped to C-S-A)
" CTRL-X and SHIFT-Del are Cut (was Decrement, now C-S-X)
" CTRL-C and CTRL-Insert are Copy
" CTRL-V and SHIFT-Insert are Paste (was Quote, now C-Q)
" CTRL-S is Save, also in Insert mode
" CTRL-Z is Undo; not in cmdline though
" CTRL-Y is Redo (although not repeat); not in cmdline though (was ScrollUp)
" CTRL-F4 is Close window
" CTRL-Tab is Next window

syntax on
filetype on
filetype plugin on
filetype indent on

"an 1.281 ToolBar.TagBack <C-O>^M
"tmenu ToolBar.TagBack Return to previous topic (C-O)
set guioptions-=T " no toolbar

set hidden
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
"set smartindent
set autoindent
set copyindent
set co=106
set lines=60
set linespace=0
set gfn=Lucida_Console:h12:cRUSSIAN
"set mousefocus
set cursorline
set colorcolumn=80
set t_Co=256 " more colors for terminal vim
set number " show line numbers
"set relativenumber " relative numbers instead of absolute
set hlsearch
set incsearch
set ignorecase
set smartcase
"set gdefault
"display a warning if &paste is set
set statusline=%F[%M%R%H%W]\ {%Y/%{&ff}/%{&fileencoding}}%#error#%{&paste?'P':''}%*\ Line:\ %l/%L\ Col:\ %v\ Ch:\ \%04.4b/#\%04.4B\ (%p%%)
set laststatus=2
set scrolloff=3
"runtime macros/matchit.vim -- for extended functionality of "%"
set history=100
set confirm
set backup
set writebackup
set backupdir=C:\\Users\\gpruss\\AppData\\Roaming\\Vim\\Backup
set directory=C:\\Users\\gpruss\\AppData\\Local\\Temp
"set visualbell
set wildmenu " show choises in cmdline for TAB
"set wildmode=list:longest
set wildignore=.svn,.git,CVS,*.o,*.a,*.class,*.mo,*.so,*.obj,*.swp,*.jpg,*.png,*.gif
set showcmd
set shortmess=asITW
set nostartofline   " don't jump to first character when paging
set undofile
set undodir=C:\\Users\\gpruss\\AppData\\Roaming\\Vim\\Backup
set tags=./tags,.,../tags,../../tags
set pastetoggle=<M-F12>
set cpoptions-=A
set autochdir " current directory is always matching the content of the active window
"Lower timeout after typing the leader key + command
"set timeoutlen=500
"Remember some stuff after quiting vim: marks, registers, searches, buffer list
"set viminfo='20,<50,s10,h,% -- default 20,<50,s10,h,rA:,rB:
"set foldmethod=expr
"set foldexpr=getline(v:lnum)[0]==\":\"?0:1
"set listchars=tab:>-,trail:·,eol:$\s      -- shows tabs as >----- and eols as $    set nolist!

if has("multi_byte")  " http://vim.wikia.com/wiki/Working_with_Unicode
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8 bomb
  set fileencodings=ucs-bom,utf-8,cp1251,latin1
endif

"runtime macros/matchit.vim -- for extended functionality of "%"


"*** COLORS ***

colorscheme whitemoon

match ExtraWhitespace /\s\+$\|\t\+/

hi ExtraWhitespace ctermbg=lightred guibg=lightred
hi Pmenu guibg=#EEEEEE
hi PmenuSel guibg=#FFDD66
hi LineNr guifg=#333380 guibg=#E0E0E0
hi CursorLine guibg=#DCFFFF
hi ColorColumn guibg=#DCFFFF


"*** PARAMETERS ***

let MRU_Max_Entries = 60
let MRU_Window_Height = 15

let g:calendar_monday = 1
let g:calendar_mark = 'right'


"*** FUNCTIONS ***

fun! ToggleNum()
  if &rnu
    set nornu
    set nu
  else
    set nonu
    set rnu
  endif
endfun

"fun! Home()
"  let curcol = wincol()
"  normal ^
"  let newcol = wincol()
"  if newcol == curcol
"    normal 0
"  endif
"endfunction

" A mapping to make a backup of the current file.
fun! WriteBackup()
  if expand("%") != "_vimfavorites" && expand("%") != "" && !&readonly
    let src = expand("%:p")
    let dst = &backupdir . '\' . expand("%:t") . printf( '.%04X.bak',localtime()/5%0x10000 )
            " tick 5 seconds, cycles 3 days 19 hrs
    silent exec escape(':w ' . dst, '\')
  endif
endfun

fun! RemoveTrailingSpaces()
  let _s=@/
  let _c = getpos(".")
  %s/\s\+$//
  call setpos('.', _c)
  let @/=_s
endfun

fun! DoRunPyBuffer2()  " S-F5
  " Run python file and get results in new window below
  pclose! " force preview window closed
  setlocal ft=python
  " copy the buffer into a new window, then run that buffer through python
  sil %y a | below new | sil put a | sil %!C:\Python3\python.exe -
  " indicate the output window as the current previewwindow
  setlocal previewwindow ro nomodifiable nomodified
  " back into the original window
  winc p
endfun

fun! MapFnKeysForPython()
  " S-F5 execute and show in another buffer
  " F5   execute in interpreter
  " F1   show help (on current word)
  set cinwords=if,elif,else,for,while,try,except,finally,def,class|
  map <S-F5> :w<CR>:RunPyBuffer<CR>|
  map <F5> :w<CR>:!c:\python3\python.exe %<CR><CR>|
  imap <F5> <ESC>:w<CR>:!c:\python3\python.exe %<CR><CR>|
  nnoremap <F1> :silent !start c:\apps\keyhh.exe -python -\#klink "<C-R><C-W>" "C:\Python3\Doc\python322.chm"<CR><CR>|
  inoremap <F1> <ESC>:silent !start c:\apps\keyhh.exe -python -\#klink "<C-R><C-W>" "C:\Python3\Doc\python322.chm"<CR><CR>
endfun


"*** AUTOCMD ***

" Go to last file if invoked without arguments.
autocmd VimEnter * nested
  \ if argc() == 0 && bufname("%") == "" && bufname("2" + 0) != "" |
  \   exe "normal! `0" |
  \ endif

" From vimrc_example.vim distributed with Vim 7.
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Remove ending blanks on saving
autocmd BufWritePre * silent! call RemoveTrailingSpaces()

autocmd BufWritePre *.py,*.pyw silent retab
autocmd BufNewFile,BufRead *.py,*.pyw silent call MapFnKeysForPython()
"autocmd BufNewFile,BufRead *.py compiler python

autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *.coffee map <F5> :w<CR>:!co.bat %<CR><CR>
autocmd BufNewFile,BufRead *.coffee setl foldmethod=indent nofoldenable

autocmd BufRead *.c++,*.cpp map <F5> :w<CR>:!g++ %<CR><CR>

autocmd BufRead *.ijs setf j | map <F5> :w<CR>:!C:\BIN\J\bin\jconsole.exe <C-R>=expand("%:p")<CR><CR><CR>

autocmd BufRead *.htm* map <F5> :w<CR>:!start C:\BIN\Firefox\firefox.exe file:///<C-R>=expand("%:p")<CR><CR><CR>


autocmd BufRead *.rb map <F5> :w<CR>:!C:\cygwin\bin\ruby.exe %<CR><CR>
" :!%    -- the simpliest method

"au FileType helpfile nmap <buffer> <CR> <C-]> | set nonumber  " no line numbers in help

au FocusLost * :wa

"autocmd BufReadPost * call WriteBackup()       use ;b for this


"*** COMMANDS ***

command! RunPyBuffer call DoRunPyBuffer2()

command! -nargs=1 -complete=help H tab help <args>


"*** KEYS ***

let mapleader = ";"  " <Leader> default is '\'
nnoremap \ ;

" exchange h and k for my keyboard layout and other movement keys
noremap h k
noremap k h
noremap H K
noremap K H
" j and k treat wrapped lines as whole

noremap zh zk
noremap zk zh

nnoremap gh gk
nnoremap gk gh
nnoremap gK gH
nnoremap g<C-K> g<C-H>

nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj
" Up/Down go inside wrapped lines

" in insert mode ctrl+h/j move up/down to the place where insert started
"inoremap <C-H> <C-G>k
"inoremap <C-J> <C-G>j

inoremap <C-G><C-H> <C-G><C-K>
inoremap <C-G>h <C-G>k

nnoremap <C-W>H <C-W>K
nnoremap <C-W>K <C-W>H
nnoremap <C-W>h <C-W>k
nnoremap <C-W>k <C-W>h
nnoremap <C-W><C-H> <C-W><C-K>
nnoremap <C-W><C-K> <C-W><C-H>

" easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Function keys

" F2 tab<-- F3 tab--> F4 tabnew   F5 run F6 win-->   F9 wclose    F11 incr
nmap <F2> gT
imap <F2> <Esc>gT
nmap <F3> gt
imap <F3> <Esc>gt
nmap <F4> :tabnew<CR>
imap <F4> <Esc>:tabnew<CR>
nmap <F6> <C-W>w
imap <F6> <C-O><C-W>w
nmap <F9> <C-W>c
imap <F9> <Esc><C-W>c
nnoremap <F11> <C-A>
inoremap <F11> <ESC><C-A>i
" S-F5 (python) execute and show in another buffer (see in AUTOCMD)
" F5 (python, rb, html, c++) -- execute (see in AUTOCMD)
noremap <silent> <F12> :cal VimCommanderToggle()<CR>

inoremap <C-B> <C-X>

"Insert space and new-line in normal mode
nmap <Space> i <ESC>
nmap <CR> i<CR><Esc>

nmap <M-Del> dd
imap <M-Del> <C-O>dd
nmap <M-Ins> yyp
imap <M-Ins> <C-O>yy<C-O>p

noremap Y y$

vnoremap <Home> ^
vnoremap <End> $

"unset digraphs
" use only ctrl+K

" digraphs Ax Ix Ex Sx Tx ax ix ex sx tx
"          Â  Î  Ă  Ș  Ț  â  î  ă  ș  ț

" Ct Eu Li Ye Sb 0u <3  Co Rg TM DG ht *X -: +- ?2 -M 00 RT
" ¢  €  ₤  ¥  ∙  ☺  ♥   ©  ®  ™  °  þ  ×  ÷  ±  ≈  —  ∞  √

" 12 14 34 18 38 58 78  1S 2S 3S nS p* << >> .. LZ __ ^^
" ½  ¼  ¾  ⅛  ⅜  ⅝  ⅞   ¹  ²  ³  ⁿ  π  «  »  …  ◊  o_ o'

dig <3 9829 " heart
dig ^^ 769  " stress accent prev char
dig __ 818  " underscore char
dig .. 8230 " ...

dig ex 259 " a(
dig ax 226 " a^
dig ix 238 " i^
dig sx 537 " s,
dig tx 539 " t,

dig Ex 258 " A(
dig Ax 194 " A^
dig Ix 206 " I^
dig Sx 536 " S,
dig Tx 538 " T,

" LeftAlt+ a i e s t  A I E S T  because RightAlt doesn't work
"          â î ă ș ț  Â Î Ă Ș Ț

map! <M-e> <C-K>ex
map! <M-a> <C-K>ax
map! <M-i> <C-K>ix
map! <M-s> <C-K>sx
map! <M-t> <C-K>tx

map! <M-S-E> <C-K>Ex
map! <M-S-A> <C-K>Ax
map! <M-S-I> <C-K>Ix
map! <M-S-S> <C-K>Sx
map! <M-S-T> <C-K>Tx

"map <C-S> :w<Enter>
"imap <C-S> <C-O>:w<Enter>

" <C-T> - go to Tag, <C-K> - go bacK
nnoremap <C-K> <C-T>
nnoremap <C-T> <C-]>
"inoremap <F8> <Esc><C-]>c
"inoremap <F8> <Esc><C-]>c

inoremap <C-^> <C-O><C-^>

nmap <C-kMinus> <C-W>-
imap <C-kMinus> <C-W>-
nmap <C-kPlus> <C-W>+
imap <C-kPlus> <C-W>+

" S-Del Cut, S-Ins Copy, C-Ins paste
vnoremap <S-Insert> "+y
map <S-Insert> "+y
map <C-Insert> "+gP
cmap <C-Insert> <C-R>+
imap <C-Insert> <C-V>
vmap <C-Insert> <C-V>

map <C-Del> dw
imap <C-Del> <C-O>dw
map <C-BS> db
imap <C-BS> <C-O>db

" Finishing incremental search with C-N = Enter, Next
cmap <C-N> <CR>n

vmap <Tab> >gv
vmap <S-Tab> <gv
smap <Tab> <C-G>>gv
smap <S-Tab> <C-G><gv

" Expand ~~ in command line to current dir
cmap ~~ <C-R>=expand('%:p:h').'\'<cr>

" Transposing lines
nmap <M-Down> :<C-u>move .+1<CR>
nmap <M-Up> :<C-u>move .-2<CR>
imap <M-Down> <C-o>:<C-u>move .+1<CR>
imap <M-Up> <C-o>:<C-u>move .-2<CR>
vmap <M-Down> :move '>+1<CR>gv
vmap <M-Up> :move '<-2<CR>gv
nmap <silent> <M-Left> <<
nmap <silent> <M-Right> >>
vmap <silent> <M-Left> <
vmap <silent> <M-Right> >
imap <silent> <M-Left> <C-D>
imap <silent> <M-Right> <C-T>

" Transpose chars (like Ctrl-T in emacs, shell...)
"imap <C-F> <Esc>Xpa

"<home> toggles between start of line and start of text
"imap <khome> <home>
"nmap <khome> <home>
"inoremap <silent> <home> <C-O>:call Home()<CR>
"nnoremap <silent> <home> :call Home()<CR>

"Ctrl-{up,down} to scroll.
"if has("gui_running")
nmap <C-up> <C-y>
imap <C-up> <C-o><C-y>
nmap <C-down> <C-e>
imap <C-down> <C-o><C-e>
"endif

" comment selected (visual) block
nmap <leader>k :s/^/#/
vmap <leader>k :s/^/#/
nmap <leader>c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//
vmap <leader>c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//

nmap <silent> <leader>h :silent :nohlsearch<CR>

nmap <silent> <leader>w :set wrap!<CR>
nmap <silent> <leader>n :call ToggleNum()<CR>

" Open a Quickfix window for the last search
nnoremap <silent> <leader>q :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

"nmap <silent> <leader>s :set nolist!<CR>

"Search/Replace
nnoremap <leader>s :%s///g<Left><Left><Left>
nnoremap <Leader>S :%s/<c-r>=expand("<cword>")<cr>//c<left><left>

nnoremap <silent> <leader>e :split $MYVIMRC<CR>
nnoremap <silent> <leader>x :so $MYVIMRC<CR>

nmap <leader>b :call WriteBackup()<CR>

" Vertical split on the right
nmap <leader>\| :bel vsp<CR>

" Fold tags
nnoremap <leader>ft Vatzf
" Reselect pasted text
nnoremap <leader>V V`]
" Hard-wrap paragraphs of text (or gqap)
nnoremap <leader>p gqip

" C-V paste
" v   stream selection
" S-V rectangular selection
" ;v  linewise selection
nnoremap <leader>v V
noremap V <C-V>

" Visual blocks (but not in select)
xmap <Right> l
xmap <Left>  k
xmap <Up>    h
xmap <Down>  j

" print empty <a> tag
map! <leader>a <a href=""></a><ESC>5ki

"*** TEMPLATES/ABBREVS ***

" Insert name, name.ext, dir, full path (also, <C-R>% (ins), "%p (norm))
inoremap <leader>if <C-R>=expand("%:t:r")<CR>
inoremap <leader>in <C-R>=expand("%:t")<CR>
inoremap <leader>id <C-R>=expand("%:p:h")<CR>
inoremap <leader>ip <C-R>=expand("%:p")<CR>

" Date/time abbreviations -- was iab date. <c-r>=...
inoremap <leader>: <c-r>=strftime('%Y%m%d-%H%M%S')<cr>
inoremap <leader>w <c-r>=strftime('%a')<cr>
inoremap <leader>d <c-r>=strftime('%B %d, %Y')<cr>
inoremap <leader>t <c-r>=strftime('%H:%M:%S')<cr>
inoremap <leader>m <c-r>=strftime('%m/%d/%Y')<cr>
inoremap <leader>y <c-r>=strftime('%Y.%m.%d')<cr>

iabbr <silent> html. <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<body>
</body>
</html><ESC>hhhh^wwa

iabbr <silent> py. #!/usr/bin/python
# -*- encoding: UTF-8 -*-

if __name__=="__main__":
  .

iabbr <silent> main. #include <stdio.h>
int
main( int argc, char* argv[] )
{
  return 0;
}<ESC>hh^

" for Contacts but it's good for txt too
syn match ContactName "^\C[A-Z]\S*\(\s[A-Z]\S*\)*"
hi ContactName guifg=#000080 gui=bold
syn match ContactDate "\d\{2,4}/\d\d/\d\d"
hi ContactDate guifg=#8800CC
syn match ContactTag "=[a-z0-9][.a-z0-9]*"
hi ContactTag guifg=#CC00CC
syn match ContactAttr "[A-Za-z][.A-Za-z0-9]*:"
hi ContactAttr guifg=#440000 gui=bold

" hi def link htmlTag Identifier
hi def link htmlEndTag Function
hi def link xmlEndTag Function

" J file type
au BufNewFile,BufRead *.ijs    setf j

" vim:fenc=utf-8:
"*** EOF ***
