" Vim color file
" Maintainer: Georgiy Pruss
" Last Change: 2010 SEP 04

" This color scheme uses a light grey background.

" First remove all existing highlighting.
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "whitemoon"

hi Normal ctermfg=Black ctermbg=LightGrey guifg=Black guibg=White

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg term=standout ctermbg=DarkRed ctermfg=Red gui=bold guibg=#FFEE66 guifg=Red
hi Error term=standout ctermbg=DarkRed ctermfg=Red gui=bold guibg=#FFEE66 guifg=Red
hi IncSearch term=reverse cterm=reverse gui=reverse
hi ModeMsg term=bold cterm=bold gui=bold
hi StatusLine term=reverse,bold cterm=reverse,bold gui=reverse,bold
hi StatusLineNC term=reverse cterm=reverse gui=reverse
hi VertSplit term=reverse cterm=reverse gui=reverse
hi Visual term=reverse ctermbg=grey guibg=grey80
hi VisualNOS term=underline,bold cterm=underline,bold gui=underline,bold
hi DiffText term=reverse cterm=bold ctermbg=Red gui=bold guibg=Red

"hi Cursor guibg=RED guifg=NONE
"hi lCursor guibg=Cyan guifg=NONE
"hi Directory term=bold ctermfg=DarkBlue guifg=Blue
"hi MoreMsg term=bold ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi NonText term=bold ctermfg=Blue gui=bold guifg=Blue guibg=grey80
"hi Question term=standout ctermfg=DarkGreen gui=bold guifg=SeaGreen
"hi Search term=reverse ctermbg=Yellow ctermfg=NONE guibg=Yellow guifg=NONE
"hi SpecialKey term=bold ctermfg=DarkBlue guifg=Blue
hi Title term=bold ctermfg=DarkMagenta gui=bold guifg=#FF0080
"hi WarningMsg term=standout ctermfg=DarkRed guifg=Red
"hi WildMenu term=standout ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
"hi Folded term=standout ctermbg=Grey ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
"hi FoldColumn term=standout ctermbg=Grey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
"hi DiffAdd term=bold ctermbg=LightBlue guibg=LightBlue
"hi DiffChange term=bold ctermbg=LightMagenta guibg=LightMagenta
"hi DiffDelete term=bold ctermfg=Blue ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan
hi LineNr term=underline ctermfg=Brown guifg=grey20 guibg=#FFFFE8
hi CursorLine term=underline cterm=underline guibg=#F0F8FF
hi CursorColumn term=reverse ctermbg=grey guibg=grey90

"hi SpecialChar guifg=Red     guibg=#DFE9F2
hi SpecialChar gui=bold guifg=#002E52
hi SpecialCharInStr gui=underline guifg=#BF525F
hi Type guifg=Brown
hi VarDef guifg=#C02040
hi Operator guifg=Blue
"hi Comment guifg=#886B60
hi Comment gui=italic guifg=#886B60
hi String guifg=#008080
hi Number guifg=#E200F0
hi Boolean guifg=Red
hi pythonEscape guifg=Purple
hi pythonOperator gui=bold guifg=DarkBlue
hi ExtraWhiteSpace guibg=#B8EAFF
hi Function guifg=Blue
hi Identifier guifg=DarkBlue
hi Statement term=bold cterm=bold ctermfg=DarkBlue gui=bold guifg=DarkBlue
hi BoldId term=bold cterm=bold ctermfg=Blue gui=bold guifg=Blue
hi BoldIdCaps term=bold cterm=bold ctermfg=Magenta gui=bold guifg=#950095
hi IdCaps ctermfg=Magenta guifg=#950095

" Colors for syntax highlighting
"hi Constant term=underline ctermfg=DarkRed guifg=Magenta guibg=grey95
"hi Special term=bold ctermfg=DarkMagenta guifg=SlateBlue guibg=grey95
if &t_Co > 8
  hi Statement term=bold cterm=bold ctermfg=DarkBlue gui=bold guifg=DarkBlue
endif
hi Ignore ctermfg=LightGrey guifg=grey90

" vim: sw=2
