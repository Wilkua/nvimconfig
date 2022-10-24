-- Key Mappings

-- Remap leader character to space
vim.g.mapleader = ' '

-- Map keys with "remap = true" by default
local noremap = function (mode, lhs, rhs, opts)
    local opts = opts or {}
    if opts['noremap'] == nil then opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Set arrow keys to move between windows
noremap('n', '<up>', '<c-w>k')
noremap('n', '<down>', '<c-w>j')
noremap('n', '<left>', '<c-w>h')
noremap('n', '<right>', '<c-w>l')

-- Use shift + arrow keys to move windows around
noremap('n', '<s-up>', '<c-w><s-k>')
noremap('n', '<s-down>', '<c-w><s-j>')
noremap('n', '<s-left>', '<c-w><s-h>')
noremap('n', '<s-right>', '<c-w><s-l>')

-- Cancel insert, move windows, start insert
noremap('i', '<up>', '<esc><c-w>ka')
noremap('i', '<down>', '<esc><c-w>ja')
noremap('i', '<left>', '<esc><c-w>ha')
noremap('i', '<right>', '<esc><c-w>la')

-- Shortcut to rapidly toggle 'set list'
noremap('n', '<leader>l', ':set list!<CR>', { silent = true })

-- Clear search highlighting
noremap('n', '<leader><space>', ':noh<cr>', { silent = true })

-- Quick upper- and lowercase word conversion
noremap('n', '<leader>U', 'gUiw')
noremap('n', '<leader>u', 'guiw')

-- Don't use Ex mode, use Q for formatting
vim.keymap.set('n', 'Q', 'gq')

-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
noremap('i', '<c-u>', '<c-g>u<c-U>')

-- Center the line moved to with G
noremap('n', 'G', 'Gzz')

-- Center the found search item
noremap('n', 'n', 'nzz')

-- Faster screen movement
noremap('n', '<c-e>', '5<c-e>')
noremap('n', '<c-y>', '5<c-y>')

-- Settings

local set = vim.opt

set.encoding = 'utf-8'               -- Set the encoding to UTF-8
set.laststatus = 2                   -- Set the status line to have 2 rows
set.scrolloff = 3                    -- Always keep three lines below the cursor when scrolling
set.showmode = false                 -- Hide the mode from the default status bar
set.backup = false                   -- do not keep a backup file, use versions instead
set.history = 50                     -- Keep 50 lines of command line history
set.showcmd = true                   -- Display incomplete commands
set.tabstop = 4                      -- Set the tab stop to 4 spaces
set.softtabstop = 4                  -- Soft tab stop
set.shiftwidth = 4                   -- Set the shift width to 4 spaces
set.expandtab = true                 -- Turn tabs into spaces.
set.number = true                    -- Always enable line numbers
set.relativenumber = true            -- Enable relative line numbers
set.autoindent = true                -- Turn on auto indent
set.cursorline = true                -- Highlight the line the cursor is on
set.wrap = false                     -- Disable line wrapping
set.mousehide = true                 -- Hide the mouse when typing text
set.ttyfast = true                   -- Fast terminal refreshing
set.ch = 1                           -- Set command height
set.wildmenu = true                  -- Enable command line listing
set.wildmode = 'list:longest'        -- See :help for details
set.ignorecase = true                -- Case-insensitive searching
set.smartcase = true                 -- Case-sensitive searching when using upper case
set.incsearch = true                 -- Do incremental searching
set.hlsearch = true                  -- Highlight search results
set.gdefault = true                  -- Default to using 'global' substitution
set.virtualedit = 'block'            -- Block selections are always rectangular
set.completeopt = 'menuone,noselect' -- always show menu; don't auto select; no preview
set.path:append('**')                     -- Include working direcotry in search path
-- set.listchars = "tab:\u25B8 ,trail:\uB7,eol:\uAC" -- Set hidden characters

-- Custom statusline setup
-- local statusln = ''
-- statusln = statusln .. '%(\ %{mode()}\ %)'
-- statusln = statusln .. '%<%.60f%(\ [%M%R%H]%)'
-- statusln = statusln .. '%='
-- statusln = statusln .. '%y\ %{strlen(&fenc)?&fenc:&enc}'
-- statusln = statusln .. "%{strlen(&ff)?'['.&ff.']':''}"
-- statusln = statusln .. '%(\ %c\ %P\ %)'
-- set.statusline = statusln

if vim.fn.has('nvim') == 1 then
    -- For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end

-- For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
-- Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
-- < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if vim.fn.has('termguicolors') == 1 then
    set.termguicolors = true
end

if vim.fn.has('win32') == 1 then
    set.guifont = 'FiraCode_NFM:h12'
else
    set.guifont = 'FiraCode_Nerd_Font_Mono:h12'
end

-- Syntax Highlighting
vim.cmd('syntax on')
set.background = 'dark'
vim.cmd('colorscheme nightfox')

----------------------
-- Plugin Detection --
----------------------

-- func! s:CheckNewPlugins()
--     let pluginPath = expand(stdpath('data') . '/site/pack/0/start')
--     let cmd = 'ls "' . pluginPath . '"'
--     if has('win32')
--         let cmd = 'DIR /B "' . pluginPath . '"'
--     endif
--
--     let newPlugins = systemlist(cmd)
--     let pluginNoteFile = expand('~/.nvim_plugins')
--     let curPlugins = []
--     if filereadable(pluginNoteFile)
--         let curPlugins = readfile(pluginNoteFile)
--     endif
--     for plugin in newPlugins
--         let plugin = substitute(plugin, '\r', '', '')
--         if index(curPlugins, plugin) < 0
--             let docPath = finddir('doc', pluginPath . '/' . plugin)
--             if docPath != ''
--                 execute 'helptags' docPath
--                 echomsg 'Added help tags for' plugin
--             endif
--
--             " We'll write the plugin to the list regardless of its doc
--             " situation
--             call writefile([plugin], pluginNoteFile, 'a')
--         endif
--     endfor
-- endfunction
--
-- call s:CheckNewPlugins()

----------------------
---- Plugin configs --
----------------------

-- JSON Syntax
vim.g.vim_json_syntax_conceal = 0  -- Don't hide quotes in JSON files

-- EditorConfig
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}

-- Make LUA loading faster
local _, _ = pcall(require, 'impatient')

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
local luasnip_ok, luasnip = pcall(require, 'luasnip')

if cmp_ok and luasnip_ok then
    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

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
    -- Setup lsp funcitonality
    local mapopts = { silent = true }
    noremap('n', '<leader>e', vim.diagnostic.open_float, mapopts)
    noremap('n', '[d', vim.diagnostic.goto_prev, mapopts)
    noremap('n', ']d', vim.diagnostic.goto_next, mapopts)
    noremap('n', '<leader>q', vim.diagnostic.setloclist, mapopts)

    local on_attach = function (client, bufnr)
        local bufopts = { silent = true, buffer = bufnr }
        noremap('n', 'gD', vim.lsp.buf.declaration, bufopts)
        noremap('n', 'gd', vim.lsp.buf.definition, bufopts)
        noremap('n', 'K', vim.lsp.buf.hover, bufopts)
        noremap('n', 'gi', vim.lsp.buf.implementation, bufopts)
        noremap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        noremap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        noremap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        noremap('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        noremap('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        noremap('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        noremap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        noremap('n', 'gr', vim.lsp.buf.references, bufopts)
        noremap('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    lsp.rust_analyzer.setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    lsp.tsserver.setup {
        capabilities = capabilities,
        on_attach = on_attach,
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

-- Treesitter configuration
local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter.config')
if treesitter_ok then
    treesitter.setup {
        ensure_installed = {},
        sync_install = false,
        ignore_install = {},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting  = false,
        },
        indent = { enable = false },
        context_commentstring = { enable = true },
    }
end

-- Comment configuration
local comment_ok, comment = pcall(require, 'Comment')
if comment_ok then
    comment.setup();
end

-- Aerial configuration
local aerial_ok, aerial = pcall(require, 'aerial')
if aerial_ok then
    aerial.setup {}
end

-- Telescope configuration
local telescope_ok, telescope = pcall(require, 'telescope')
if telescope_ok then
    local builtin = require'telescope.builtin'

    -- Key mapping
    noremap('n', '<leader>ff', builtin.find_files)
    noremap('n', '<leader>fg', builtin.live_grep)
    noremap('n', '<leader>fb', builtin.buffers)
    noremap('n', '<leader>fh', builtin.help_tags)

    telescope.setup {
        defaults = {
            selection_caret = '->',
            path_display = { 'truncate' },
            file_ignore_patterns = {'node_modules'},
            selection_strategy = 'reset',
            sorting_strategy = 'descending',
            layout_strategy = 'horizontal',
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = true,
                override_file_sorter = true,
            },
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            }
        }
    }

    if aerial_ok then
        telescope.load_extension 'aerial'
    end

    -- There's no good way to detect if this plugin is available,
    -- so just make sure it's installed. Alternatively, just disable
    -- this part alltogether.
    if vim.fn.has 'win32' == 1 then
        telescope.load_extension 'fzy_native'
    else
        telescope.load_extension 'fzf'
    end
end

local autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
if autopairs_ok then
    autopairs.setup {}
end

-- Feline
local feline_ok, feline = pcall(require, 'feline')
if feline_ok then
    feline.setup()
end

local toggleterm_ok, toggleterm = pcall(require, 'toggleterm')
if toggleterm_ok then
    toggleterm.setup {}
end

