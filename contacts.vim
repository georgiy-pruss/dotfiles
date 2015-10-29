" Vim syntax file
" Language:     Contacts file
" Maintainer:   Georgiy Pruss <....>
" URL:          http://....
" Last Change:  2011-02-07
" Filenames:    contacts.*
" Version:      1.0.0

" For version 5.x: Clear all syntax items.
" For version 6.x: Quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match ContactName "^\C[A-Z]\S*\(\s[&(A-Z]\S*\)*"
syn match ContactDate "\d\d/\d\d/\d\d"
syn match ContactTag "=[a-z][.a-z0-9]*"
syn match ContactAttr "[a-z][.a-z0-9]*:"
syn match ContactCmnt "#.*$"
syn match ContactStr "\".*\""

hi ContactName guifg=#000080 gui=bold
hi ContactDate guifg=#8800CC
hi ContactTag guifg=#CC00CC
hi ContactAttr guifg=#440000 gui=bold
hi link ContactCmnt Comment
hi link ContactStr String

let b:current_syntax = "contacts"
