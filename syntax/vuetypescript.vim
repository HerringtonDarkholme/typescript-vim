" Vim syntax file
" Language: vuetypescript
" Author: MicroSoft Open Technologies Inc.
" Version: 0.1
" Credits: Zhao Yi, Claudio Fleiner, Scott Shattuck, Jose Elera Campana

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = "vuetypescript"
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("vuetypescript_fold")
  unlet vuetypescript_fold
endif

"" dollar sign is permitted anywhere in an identifier
setlocal iskeyword+=$

syntax sync fromstart

"" syntax coloring for Node.js shebang line
syn match shebang "^#!.*/bin/env\s\+node\>"
hi link shebang Comment

"" vuetypescript comments"{{{
syn keyword vuetypescriptCommentTodo TODO FIXME XXX TBD contained
syn match vuetypescriptLineComment "\/\/.*" contains=@Spell,vuetypescriptCommentTodo,vuetypescriptRef
syn match vuetypescriptRefComment /\/\/\/<\(reference\|amd-\(dependency\|module\)\)\s\+.*\/>$/ contains=vuetypescriptRefD,vuetypescriptRefS
syn region vuetypescriptRefD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+
syn region vuetypescriptRefS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+

syn match vuetypescriptCommentSkip "^[ \t]*\*\($\|[ \t]\+\)"
syn region vuetypescriptComment start="/\*" end="\*/" contains=@Spell,vuetypescriptCommentTodo extend
"}}}
"" JSDoc support start"{{{
if !exists("vuetypescript_ignore_typescriptdoc")
  syntax case ignore

" syntax coloring for JSDoc comments (HTML)
"unlet b:current_syntax

  syntax region vuetypescriptDocComment start="/\*\*\s*$" end="\*/" contains=vuetypescriptDocTags,vuetypescriptCommentTodo,vuetypescriptCvsTag,@vuetypescriptHtml,@Spell fold extend
  syntax match vuetypescriptDocTags contained "@\(param\|argument\|requires\|exception\|throws\|type\|class\|extends\|see\|link\|member\|module\|method\|title\|namespace\|optional\|default\|base\|file\)\>" nextgroup=vuetypescriptDocParam,vuetypescriptDocSeeTag skipwhite
  syntax match vuetypescriptDocTags contained "@\(beta\|deprecated\|description\|fileoverview\|author\|license\|version\|returns\=\|constructor\|private\|protected\|final\|ignore\|addon\|exec\)\>"
  syntax match vuetypescriptDocParam contained "\%(#\|\w\|\.\|:\|\/\)\+"
  syntax region vuetypescriptDocSeeTag contained matchgroup=vuetypescriptDocSeeTag start="{" end="}" contains=vuetypescriptDocTags

  syntax case match
endif "" JSDoc end
"}}}
syntax case match

"" Syntax in the vuetypescript code"{{{
syn match vuetypescriptSpecial "\\\d\d\d\|\\."
syn region vuetypescriptStringD start=+"+ skip=+\\\\\|\\"+ end=+"\|$+  contains=vuetypescriptSpecial,@htmlPreproc extend
syn region vuetypescriptStringS start=+'+ skip=+\\\\\|\\'+ end=+'\|$+  contains=vuetypescriptSpecial,@htmlPreproc extend
syn region vuetypescriptStringB start=+`+ skip=+\\\\\|\\`+ end=+`+  contains=vuetypescriptInterpolation,vuetypescriptSpecial,@htmlPreproc extend

syn region vuetypescriptInterpolation matchgroup=vuetypescriptInterpolationDelimiter
      \ start=/${/ end=/}/ contained
      \ contains=@vuetypescriptExpression

syn match vuetypescriptNumber "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region vuetypescriptRegexpString start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
" syntax match vuetypescriptSpecial "\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\."
" syntax region vuetypescriptStringD start=+"+ skip=+\\\\\|\\$"+ end=+"+ contains=vuetypescriptSpecial,@htmlPreproc
" syntax region vuetypescriptStringS start=+'+ skip=+\\\\\|\\$'+ end=+'+ contains=vuetypescriptSpecial,@htmlPreproc
" syntax region vuetypescriptRegexpString start=+/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{,3}+ contains=vuetypescriptSpecial,@htmlPreproc oneline
" syntax match vuetypescriptNumber /\<-\=\d\+L\=\>\|\<0[xX]\x\+\>/
syntax match vuetypescriptFloat /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
" syntax match vuetypescriptLabel /\(?\s*\)\@<!\<\w\+\(\s*:\)\@=/

syn match vuetypescriptDecorators /@\([_$a-zA-Z][_$a-zA-Z0-9]*\.\)*[_$a-zA-Z][_$a-zA-Z0-9]*\>/
"}}}
"" vuetypescript Prototype"{{{
syntax keyword vuetypescriptPrototype contained prototype
"}}}
" DOM, Browser and Ajax Support {{{
""""""""""""""""""""""""
syntax keyword vuetypescriptBrowserObjects window navigator screen history location

syntax keyword vuetypescriptDOMObjects document event HTMLElement Anchor Area Base Body Button Form Frame Frameset Image Link Meta Option Select Style Table TableCell TableRow Textarea
syntax keyword vuetypescriptDOMMethods contained createTextNode createElement insertBefore replaceChild removeChild appendChild hasChildNodes cloneNode normalize isSupported hasAttributes getAttribute setAttribute removeAttribute getAttributeNode setAttributeNode removeAttributeNode getElementsByTagName hasAttribute getElementById adoptNode close compareDocumentPosition createAttribute createCDATASection createComment createDocumentFragment createElementNS createEvent createExpression createNSResolver createProcessingInstruction createRange createTreeWalker elementFromPoint evaluate getBoxObjectFor getElementsByClassName getSelection getUserData hasFocus importNode
syntax keyword vuetypescriptDOMProperties contained nodeName nodeValue nodeType parentNode childNodes firstChild lastChild previousSibling nextSibling attributes ownerDocument namespaceURI prefix localName tagName

syntax keyword vuetypescriptAjaxObjects XMLHttpRequest
syntax keyword vuetypescriptAjaxProperties contained readyState responseText responseXML statusText
syntax keyword vuetypescriptAjaxMethods contained onreadystatechange abort getAllResponseHeaders getResponseHeader open send setRequestHeader

syntax keyword vuetypescriptPropietaryObjects ActiveXObject
syntax keyword vuetypescriptPropietaryMethods contained attachEvent detachEvent cancelBubble returnValue

syntax keyword vuetypescriptHtmlElemProperties contained className clientHeight clientLeft clientTop clientWidth dir href id innerHTML lang length offsetHeight offsetLeft offsetParent offsetTop offsetWidth scrollHeight scrollLeft scrollTop scrollWidth style tabIndex target title

syntax keyword vuetypescriptEventListenerKeywords contained blur click focus mouseover mouseout load item

syntax keyword vuetypescriptEventListenerMethods contained scrollIntoView addEventListener dispatchEvent removeEventListener preventDefault stopPropagation
" }}}
"" Programm Keywords"{{{
syntax keyword vuetypescriptSource import export from as
syntax keyword vuetypescriptIdentifier arguments this let var void const
syntax keyword vuetypescriptOperator delete new instanceof typeof
syntax keyword vuetypescriptBoolean true false
syntax keyword vuetypescriptNull null undefined
syntax keyword vuetypescriptMessage alert confirm prompt status
syntax keyword vuetypescriptGlobal self top parent
syntax keyword vuetypescriptDeprecated escape unescape all applets alinkColor bgColor fgColor linkColor vlinkColor xmlEncoding
"}}}
"" Statement Keywords"{{{
syntax keyword vuetypescriptConditional if else switch
syntax keyword vuetypescriptRepeat do while for in of
syntax keyword vuetypescriptBranch break continue yield await
syntax keyword vuetypescriptLabel case default async readonly
syntax keyword vuetypescriptStatement return with

syntax keyword vuetypescriptGlobalObjects Array Boolean Date Function Infinity Math Number NaN Object Packages RegExp String Symbol netscape

syntax keyword vuetypescriptExceptions try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError

syntax keyword vuetypescriptReserved constructor declare as interface module abstract enum int short export interface static byte extends long super char final native synchronized class float package throws goto private transient debugger implements protected volatile double import public type namespace from get set keyof
"}}}
"" vuetypescript/DOM/HTML/CSS specified things"{{{

" vuetypescript Objects"{{{
  syn match vuetypescriptFunction "(super\s*|constructor\s*)" contained nextgroup=vuetypescriptVars
  syn region vuetypescriptVars start="(" end=")" contained contains=vuetypescriptParameters transparent keepend
  syn match vuetypescriptParameters "([a-zA-Z0-9_?.$][\w?.$]*)\s*:\s*([a-zA-Z0-9_?.$][\w?.$]*)" contained skipwhite
"}}}
" DOM2 Objects"{{{
  syntax keyword vuetypescriptType DOMImplementation DocumentFragment Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction void any string boolean number symbol never object
  syntax keyword vuetypescriptExceptions DOMException
"}}}
" DOM2 CONSTANT"{{{
  syntax keyword vuetypescriptDomErrNo INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
  syntax keyword vuetypescriptDomNodeConsts ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE
"}}}
" HTML events and internal variables"{{{
  syntax case ignore
  syntax keyword vuetypescriptHtmlEvents onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize onload onsubmit
  syntax case match
"}}}

" Follow stuff should be highligh within a special context
" While it can't be handled with context depended with Regex based highlight
" So, turn it off by default
if exists("vuetypescript_enable_domhtmlcss")

" DOM2 things"{{{
    syntax match vuetypescriptDomElemAttrs contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
    syntax match vuetypescriptDomElemFuncs contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=vuetypescriptParen skipwhite
"}}}
" HTML things"{{{
    syntax match vuetypescriptHtmlElemAttrs contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
    syntax match vuetypescriptHtmlElemFuncs contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=vuetypescriptParen skipwhite
"}}}
" CSS Styles in vuetypescript"{{{
    syntax keyword vuetypescriptCssStyles contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
    syntax keyword vuetypescriptCssStyles contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
    syntax keyword vuetypescriptCssStyles contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
    syntax keyword vuetypescriptCssStyles contained bottom height left position right top width zIndex
    syntax keyword vuetypescriptCssStyles contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
    syntax keyword vuetypescriptCssStyles contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
    syntax keyword vuetypescriptCssStyles contained listStyle listStyleImage listStylePosition listStyleType
    syntax keyword vuetypescriptCssStyles contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
    syntax keyword vuetypescriptCssStyles contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
    syntax keyword vuetypescriptCssStyles contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
    syntax keyword vuetypescriptCssStyles contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor
"}}}
endif "DOM/HTML/CSS

" Highlight ways"{{{
syntax match vuetypescriptDotNotation "\."        nextgroup=vuetypescriptPrototype,vuetypescriptDomElemAttrs,vuetypescriptDomElemFuncs,vuetypescriptDOMMethods,vuetypescriptDOMProperties,vuetypescriptHtmlElemAttrs,vuetypescriptHtmlElemFuncs,vuetypescriptHtmlElemProperties,vuetypescriptAjaxProperties,vuetypescriptAjaxMethods,vuetypescriptPropietaryMethods,vuetypescriptEventListenerMethods skipwhite skipnl
syntax match vuetypescriptDotNotation "\.style\." nextgroup=vuetypescriptCssStyles
"}}}

"" end DOM/HTML/CSS specified things""}}}


"" Code blocks
syntax cluster vuetypescriptAll contains=vuetypescriptComment,vuetypescriptLineComment,vuetypescriptDocComment,vuetypescriptStringD,vuetypescriptStringS,vuetypescriptStringB,vuetypescriptRegexpString,vuetypescriptNumber,vuetypescriptFloat,vuetypescriptDecorators,vuetypescriptLabel,vuetypescriptSource,vuetypescriptType,vuetypescriptOperator,vuetypescriptBoolean,vuetypescriptNull,vuetypescriptFuncKeyword,vuetypescriptConditional,vuetypescriptGlobal,vuetypescriptRepeat,vuetypescriptBranch,vuetypescriptStatement,vuetypescriptGlobalObjects,vuetypescriptMessage,vuetypescriptIdentifier,vuetypescriptExceptions,vuetypescriptReserved,vuetypescriptDeprecated,vuetypescriptDomErrNo,vuetypescriptDomNodeConsts,vuetypescriptHtmlEvents,vuetypescriptDotNotation,vuetypescriptBrowserObjects,vuetypescriptDOMObjects,vuetypescriptAjaxObjects,vuetypescriptPropietaryObjects,vuetypescriptDOMMethods,vuetypescriptHtmlElemProperties,vuetypescriptDOMProperties,vuetypescriptEventListenerKeywords,vuetypescriptEventListenerMethods,vuetypescriptAjaxProperties,vuetypescriptAjaxMethods,vuetypescriptFuncArg

if main_syntax == "vuetypescript"
  syntax sync clear
  syntax sync ccomment vuetypescriptComment minlines=200
" syntax sync match vuetypescriptHighlight grouphere vuetypescriptBlock /{/
endif

syntax keyword vuetypescriptFuncKeyword function
"syntax region vuetypescriptFuncDef start="function" end="\(.*\)" contains=vuetypescriptFuncKeyword,vuetypescriptFuncArg keepend
"syntax match vuetypescriptFuncArg "\(([^()]*)\)" contains=vuetypescriptParens,vuetypescriptFuncComma contained
"syntax match vuetypescriptFuncComma /,/ contained
" syntax region vuetypescriptFuncBlock contained matchgroup=vuetypescriptFuncBlock start="{" end="}" contains=@vuetypescriptAll,vuetypescriptParensErrA,vuetypescriptParensErrB,vuetypescriptParen,vuetypescriptBracket,vuetypescriptBlock fold

syn match vuetypescriptBraces "[{}\[\]]"
syn match vuetypescriptParens "[()]"
syn match vuetypescriptOpSymbols "=\{1,3}\|!==\|!=\|<\|>\|>=\|<=\|++\|+=\|--\|-="
syn match vuetypescriptEndColons "[;,]"
syn match vuetypescriptLogicSymbols "\(&&\)\|\(||\)"

" vuetypescriptFold Function {{{

" function! vuetypescriptFold()

" skip curly braces inside RegEx's and comments
syn region foldBraces start=/{/ skip=/\(\/\/.*\)\|\(\/.*\/\)/ end=/}/ transparent fold keepend extend

" setl foldtext=FoldText()
" endfunction

" au FileType vuetypescript call vuetypescriptFold()

" }}}

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_typescript_syn_inits")
  if version < 508
    let did_typescript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  "vuetypescript highlighting
  HiLink vuetypescriptParameters Operator
  HiLink vuetypescriptSuperBlock Operator

  HiLink vuetypescriptEndColons Exception
  HiLink vuetypescriptOpSymbols Operator
  HiLink vuetypescriptLogicSymbols Boolean
  HiLink vuetypescriptBraces Function
  HiLink vuetypescriptParens Operator
  HiLink vuetypescriptComment Comment
  HiLink vuetypescriptLineComment Comment
  HiLink vuetypescriptRefComment Include
  HiLink vuetypescriptRefS String
  HiLink vuetypescriptRefD String
  HiLink vuetypescriptDocComment Comment
  HiLink vuetypescriptCommentTodo Todo
  HiLink vuetypescriptCvsTag Function
  HiLink vuetypescriptDocTags Special
  HiLink vuetypescriptDocSeeTag Function
  HiLink vuetypescriptDocParam Function
  HiLink vuetypescriptStringS String
  HiLink vuetypescriptStringD String
  HiLink vuetypescriptStringB String
  HiLink vuetypescriptInterpolationDelimiter Delimiter
  HiLink vuetypescriptRegexpString String
  HiLink vuetypescriptGlobal Constant
  HiLink vuetypescriptCharacter Character
  HiLink vuetypescriptPrototype Type
  HiLink vuetypescriptConditional Conditional
  HiLink vuetypescriptBranch Conditional
  HiLink vuetypescriptIdentifier Identifier
  HiLink vuetypescriptRepeat Repeat
  HiLink vuetypescriptStatement Statement
  HiLink vuetypescriptFuncKeyword Function
  HiLink vuetypescriptMessage Keyword
  HiLink vuetypescriptDeprecated Exception
  HiLink vuetypescriptError Error
  HiLink vuetypescriptParensError Error
  HiLink vuetypescriptParensErrA Error
  HiLink vuetypescriptParensErrB Error
  HiLink vuetypescriptParensErrC Error
  HiLink vuetypescriptReserved Keyword
  HiLink vuetypescriptOperator Operator
  HiLink vuetypescriptType Type
  HiLink vuetypescriptNull Type
  HiLink vuetypescriptNumber Number
  HiLink vuetypescriptFloat Number
  HiLink vuetypescriptDecorators Special
  HiLink vuetypescriptBoolean Boolean
  HiLink vuetypescriptLabel Label
  HiLink vuetypescriptSpecial Special
  HiLink vuetypescriptSource Special
  HiLink vuetypescriptGlobalObjects Special
  HiLink vuetypescriptExceptions Special

  HiLink vuetypescriptDomErrNo Constant
  HiLink vuetypescriptDomNodeConsts Constant
  HiLink vuetypescriptDomElemAttrs Label
  HiLink vuetypescriptDomElemFuncs PreProc

  HiLink vuetypescriptHtmlElemAttrs Label
  HiLink vuetypescriptHtmlElemFuncs PreProc

  HiLink vuetypescriptCssStyles Label

  " Ajax Highlighting
  HiLink vuetypescriptBrowserObjects Constant

  HiLink vuetypescriptDOMObjects Constant
  HiLink vuetypescriptDOMMethods Function
  HiLink vuetypescriptDOMProperties Special

  HiLink vuetypescriptAjaxObjects Constant
  HiLink vuetypescriptAjaxMethods Function
  HiLink vuetypescriptAjaxProperties Special

  HiLink vuetypescriptFuncDef Title
  HiLink vuetypescriptFuncArg Special
  HiLink vuetypescriptFuncComma Operator

  HiLink vuetypescriptHtmlEvents Special
  HiLink vuetypescriptHtmlElemProperties Special

  HiLink vuetypescriptEventListenerKeywords Keyword

  HiLink vuetypescriptNumber Number
  HiLink vuetypescriptPropietaryObjects Constant

  delcommand HiLink
endif

" Define the htmltypescript for HTML syntax html.vim
"syntax clear htmltypescript
"syntax clear vuetypescriptExpression
syntax cluster htmltypescript contains=@vuetypescriptAll,vuetypescriptBracket,vuetypescriptParen,vuetypescriptBlock,vuetypescriptParenError
syntax cluster vuetypescriptExpression contains=@vuetypescriptAll,vuetypescriptBracket,vuetypescriptParen,vuetypescriptBlock,vuetypescriptParenError,@htmlPreproc

let b:current_syntax = "vuetypescript"
if main_syntax == 'vuetypescript'
  unlet main_syntax
endif

" vim: ts=4
