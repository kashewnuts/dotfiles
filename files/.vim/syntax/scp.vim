" Vim syntax file
" Language:		scp
" Maintainer:	Kscphun Yoshida  <bjzli.m08vo9kqs@gmail.com>
" Laspt Change:	Feb 24, 2016
" Version:		1.0.0

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn region  scpStringDQ        start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region  scpStringSQ        start=+'+  skip=+\\\\\|\\'+  end=+'+
syn match   scpNumber          "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  scpRegExp          start=+/+ skip=+\\\\\|\\/+ end=+/[gismx]\?\s*$+ end=+/[gismx]\?\s*[;,)]+me=e-1 oneline

syn match   scpComment         "//.*$" contains=scpCommentTodo
syn region  scpComment         start="/\*"  end="\*/" contains=scpCommentTodo
syn keyword scpCommentTodo     TODO FIXME XXX TBD contained

syn keyword scpInclude         Include
syn keyword scpType            Package EndPackage
syn keyword scpStatement       Continue continue Break break Return return Then then
syn keyword scpStatement       WITH With with ENDWITH EndWith endwith
syn match   scpStatement       "\<End\s\+With\>"

syn keyword scpRepeat          WHILE While while WEND Wend wend
syn keyword scpOperator        and in is not or eq
syn keyword scpException       BEGIN Begin begin CATCH Catch catch

syn keyword scpConditional     IF If if ELSEIF ElseIf elseif ELSE Else else ENDIF EndIf endif
syn match   scpConditional     "\<End\s\+If\>"
syn keyword scpConditional     Method
syn match   scpConditional     "\<End\s\+Method\>"
syn keyword scpConditional     SELECT Select select CASE Case case
syn match   scpConditional     "\<End\s\+Select\>"
syn keyword scpConstant        NIL Nil nil NULL Null null TRUE True true FALSE False false

" Define the default highlighting.
command -nargs=+ HiLink hi def link <args>

HiLink scpBraces          Function
HiLink scpComment         Comment
HiLink scpCommentTodo     Todo
HiLink scpConditional     Conditional
HiLink scpConstant        Constant
HiLink scpException       Exception
HiLink scpInclude         Include
HiLink scpNumber          Number
HiLink scpOperator        Operator
HiLink scpRegExp          Special
HiLink scpRepeat          Repeat
HiLink scpStatement       Statement
HiLink scpStringDQ        String
HiLink scpStringSQ        String
HiLink scpType            Type

delcommand HiLink

let b:current_syntax = "scp"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
