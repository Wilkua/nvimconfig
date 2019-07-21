set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "DarkVis"

hi Normal            gui=none guifg=#d4d4d4 guibg=#1e1e1e
hi SpecialKey        gui=none guifg=#cc0000
hi NonText           gui=none guifg=#aaaaaa
hi Directory         gui=none guifg=#cc8000
hi ErrorMsg          gui=none guifg=#d85050 guibg=#1e1e1e
hi Search            gui=none guibg=#773800
hi MoreMsg           gui=bold guifg=SeaGreen
hi ModeMsg           gui=bold guifg=#dcdcdc guibg=#1e1e1e
hi LineNr            gui=none guifg=#2b91af
hi Question          gui=none guifg=#dcdcdc
hi StatusLine        gui=none guifg=#dcdcdc guibg=#2e2e2e
hi StatusLineNC      gui=none guifg=#767676 guibg=#2e2e2e
hi Title             gui=bold guifg=Magenta
hi Visual            gui=none guifg=#1e1e1e guibg=#3399ff
hi WarningMsg        gui=none guifg=Red
hi Cursor            guifg=bg guibg=fg
hi CursorLine        gui=none guibg=#0f0f0f

hi Character         gui=none guifg=#ce9178
hi Comment           gui=none guifg=#608b4e
hi Constant          gui=none guifg=#b5cea8
hi Function          gui=none guifg=#dcdcaa
hi Identifier        gui=none guifg=#dcdcdc
hi Number            gui=none guifg=#b5cea8
hi Operator          gui=none guifg=#d4d4d4
hi PreProc           gui=none guifg=#569cd6
hi Special           gui=none guifg=#569cd6
hi Statement         gui=none guifg=#569cd6
hi String            gui=none guifg=#ce9178
hi Type              gui=none guifg=#4ec980

hi Error             gui=none guifg=#d85050 guibg=#1e1e1e
hi Todo              gui=none guifg=blue guibg=yellow
hi MatchParen        gui=none guifg=#dcdcdc guibg=#0d4583
hi TabLine           gui=none gui=bold guifg=blue guibg=white
hi TabLineFill       gui=bold guifg=blue guibg=white
hi TabLineSel        gui=none guifg=white guibg=blue
hi Underlined        gui=none guifg=lightblue gui=bold,underline
hi Ignore            gui=none guifg=black guibg=black

hi Pmenu             gui=none guifg=white guibg=black ctermfg=white ctermbg=black
hi PmenuSel          gui=none guifg=gold guibg=darkgray ctermfg=yellow ctermbg=black
hi PmenuSBar         gui=none guifg=green guibg=black
hi PmenuThumb        gui=none guifg=orange guibg=black

hi DiffAdd           gui=none
hi DiffChange        gui=none
hi DiffDelete        gui=none

" CTerm Colors
hi Normal            cterm=none ctermfg=white ctermbg=black
hi CursorLine        cterm=underline ctermfg=fg ctermbg=bg
hi StatusLine        cterm=bold ctermfg=white ctermbg=black
hi StatusLineNC      cterm=none ctermfg=white ctermbg=black

