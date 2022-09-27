" Key Mappings

" Remap leader character to comma
let mapleader = ','

" Set arrow keys to move between windows
nno <up> <c-w>k
nno <down> <c-w>j
nno <left> <c-w>h
nno <right> <c-w>l

" Use shift + arrow keys to move windows around
nno <s-up> <c-w><s-k>
nno <s-down> <c-w><s-j>
nno <s-left> <c-w><s-h>
nno <s-right> <c-w><s-l>

" Cancel insert, move windows, start insert
ino <up> <esc><c-w>ka
ino <down> <esc><c-w>ja
ino <left> <esc><c-w>ha
ino <right> <esc><c-w>la

" Shortcut to rapidly toggle 'set list'
nmap <leader>l :set list!<CR>

" Clear search highlighting
nnoremap <leader><space> :noh<cr>

" Quick upper- and lowercase word conversion
nnoremap <leader>U gUiw
nnoremap <leader>u guiw

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <c-u> <c-g>u<c-U>

" Create a newline below the current line but don't
" place me in insert mode
nno g<c-o> o<esc>k

" Create a newline above the current line but don't
" place me in insert mode
nno gO O<esc>j

" Center the line moved to with G
nno G Gzz

" Center the found search item
nno n nzz

" Just put the stupid things in there for me
nnoremap / /\v
vnoremap / /\v

" NERDTree toggle mapping
noremap <leader>n :NERDTreeToggle<CR>

" Faster screen movement
nnoremap <c-e> 3<c-e>
nnoremap <c-y> 3<c-y>

" Telescope functions
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


""" Settings """

set encoding=utf-8               " Set the encoding to UTF-8
set laststatus=2                 " Set the status line to have 2 rows
set nocompatible                 " Don't enable Vi compatibility
set scrolloff=3                  " Always keep three lines below the cursor when scrolling
set backspace=indent,eol,start   " Backspace over everything
set noshowmode                   " Hide the mode from the default status bar
set nobackup                     " do not keep a backup file, use versions instead
set history=50                   " Keep 50 lines of command line history
set ruler                        " Show the cursor position all the time
set showcmd                      " Display incomplete commands
set tabstop=4                    " Set the tab stop to 4 spaces
set softtabstop=4                " Soft tab stop
set shiftwidth=4                 " Set the shift width to 4 spaces
set expandtab                    " Turn tabs into spaces.
set number                       " Always enable line numbers
set relativenumber               " Enable relative line numbers
set autoindent                   " Turn on auto indent
set cursorline                   " Highlight the line the cursor is on
set nowrap                       " Disable line wrapping
set mousehide                    " Hide the mouse when typing text
set ttyfast                      " Fast terminal refreshing
set ch=1                         " Set command height
set wildmenu                     " Enable command line listing
set wildmode=list:longest        " See :help for details
set ignorecase                   " Case-insensitive searching
set smartcase                    " Case-sensitive searching when using upper case
set incsearch                    " Do incremental searching
set hlsearch                     " Highlight search results
set gdefault                     " Default to using 'global' substitution
set virtualedit=block            " Block selections are always rectangular
set completeopt=menuone,noselect " always show menu; don't auto select; no preview
set path+=**                     " Include working direcotry in search path

" Custom statusline setup
set statusline=
set statusline+=%(\ %{mode()}\ %)
set statusline+=%<%.60f%(\ [%M%R%H]%)
set statusline+=%=
set statusline+=%y\ %{strlen(&fenc)?&fenc:&enc}
set statusline+=%{strlen(&ff)?'['.&ff.']':''}
set statusline+=%(\ %c\ %P\ %)

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

" enable autoread and check the file whenever the curso is idle
set autoread
au CursorHold * checktime

" Set hidden characters
let &listchars = "tab:\u25B8 ,trail:\uB7,eol:\uAC"

""" Syntax Highlighting """
syntax on
set background=dark
colorscheme nightfox

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
   command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" command! -nargs=* -complete=shellcmd R vnew | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" Autocmd stuff
if has('autocmd')
   " autocmd BufReadPre * :set columns=(80+numberwidth)
   autocmd BufReadPre *.c,*.cpp,*.cxx,*.h,*.hpp,*.hxx,*.php,*.cs :set cindent
   " autocmd BufWritePre *.py,*.js,*.c,*.cpp,*.cxx,*.h,*.hpp,*.html,*.php,*.css,*.txt :call StripTrailingWhitespace()
endif

""" Functions """

" Highlight when a line goes over 80 columns
call matchadd('ColorColumn', '\%81v', 100)

" Strips trailing whitespaces without changing the current
" search string (because I hate trailing whitespace)
" NOTE(wilkua): This function is a bit iffy at best. Use an .editorconfig file
" with the editorconfig plugin instead for better results.
func! StripTrailingWhitespace()
    let _s = @/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/ = _s
    call cursor(l, c)
endfunction

""" Plugin Detection """

func! s:CheckNewPlugins()
    let pluginPath = expand(stdpath('data') . '/site/pack/0/start')
    let cmd = 'ls "' . pluginPath . '"'
    if has('win32')
        let cmd = 'DIR /B "' . pluginPath . '"'
    endif

    let newPlugins = systemlist(cmd)
    let pluginNoteFile = expand('~/.nvim_plugins')
    let curPlugins = []
    if filereadable(pluginNoteFile)
        let curPlugins = readfile(pluginNoteFile)
    endif
    for plugin in newPlugins
        let plugin = substitute(plugin, '\r', '', '')
        if index(curPlugins, plugin) < 0
            let docPath = finddir('doc', pluginPath . '/' . plugin)
            if docPath != ''
                execute 'helptags' docPath
                echomsg 'Added help tags for' plugin
            endif

            " We'll write the plugin to the list regardless of its doc
            " situation
            call writefile([plugin], pluginNoteFile, 'a')
        endif
    endfor
endfunction

call s:CheckNewPlugins()

""" Plugin Options """

" GitGutter
let g:gitgutter_map_keys = 0          " Disable GitGutter shortcut keys

" NERDCommenter
let g:NERDSpaceDelims = 1             " Add space ofter comment char
let g:NERDDefaultAlign = 'left'       " Left align comment marks
let g:NERDCommentEmptyLines = 1       " Comment blank lines
let g:NERDTrimTrailingWhitespace = 1  " Trim whitespace on uncomment

" JSON Syntax
let g:vim_json_syntax_conceal = 0  " Don't hide quotes in JSON files

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Lua cconfigurations
lua <<EOF

-- Define global notify
local notify_ok, notify = pcall(require, 'notify')
if notify_ok then
    vim.notify = notify
end

-- Gitsigns
local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
if gitsigns_ok then
    gitsigns.setup()
end

-- nvim-cmp
local cmp_ok, cmp = pcall(require, 'cmp')

if cmp_ok then
    cmp.setup {
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ["<Up>"] = cmp.mapping.select_prev_item(),
            ["<Down>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable,
            ["<C-e>"] = cmp.mapping {
              i = cmp.mapping.abort(),
              c = cmp.mapping.close(),
            },
            ["<CR>"] = cmp.mapping.confirm { select = false },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i",  "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        }, {
            { name = 'buffer' },
        })
    }

    -- CMP file types
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end

-- Set up lspconfig.
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local lsp_ok, lsp = pcall(require, 'lspconfig')
if cmp_nvim_lsp_ok and lsp_ok then
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lsp = require('lspconfig')
    lsp.rust_analyzer.setup {
        capabilities = capabilities,
    }
    lsp.tsserver.setup {
        capabilities = capabilities,
    }
end

-- null-ls cconfigurations
local null_ls_ok, null_ls = pcall(require, 'null-ls')
if null_ls_ok then
    null_ls.setup {
        sources = {
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.diagnostics.php,
            null_ls.builtins.formatting.rustfmt,
        },
    }
end
EOF

