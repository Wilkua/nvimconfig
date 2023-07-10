-- Speed up lua loading
-- Neovim 0.9+
vim.loader.enable()

-- Remap leader character to space
vim.g.mapleader = ' '

-- Settings

local set = vim.opt

set.encoding = 'utf-8'               -- Set the encoding to UTF-8
set.fileformat = 'unix'              -- Always use Unix line endings
set.laststatus = 2                   -- Set the status line to have 2 rows
set.scrolloff = 5                    -- Always keep five lines below and above the cursor when scrolling
set.sidescrolloff = 8                -- Always keep characters at te edge of the window
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
set.copyindent = true                -- Copy indent structure from other lines
set.cursorline = true                -- Highlight the line the cursor is on
set.wrap = false                     -- Disable line wrapping
set.mousehide = true                 -- Hide the mouse when typing text
set.ttyfast = true                   -- Fast terminal refreshing
set.ch = 0                           -- Set command height
set.wildmenu = true                  -- Enable command line listing
set.wildmode = 'list:longest'        -- See :help for details
set.ignorecase = true                -- Case-insensitive searching
set.smartcase = true                 -- Case-sensitive searching when using upper case
set.incsearch = true                 -- Do incremental searching
set.hlsearch = true                  -- Highlight search results
set.gdefault = true                  -- Default to using 'global' substitution
set.virtualedit = 'block'            -- Block selections are always rectangular
set.completeopt = 'menuone,noselect' -- always show menu; don't auto select; no preview
set.timeoutlen = 500                 -- Faster timeout for key sequence commands
set.updatetime = 400                 -- Faster time before updating swap
set.path:append('**')                -- Include working direcotry in search path
set.signcolumn = 'yes'               -- Always show sign column

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

set.guifont = 'FiraCode_Nerd_Font:h12'

-- ----------------
-- Neovide setup --
-- ----------------

if vim.g.neovide then
    vim.g.neovide_floating_blur_amount_x = 8.0
    vim.g.neovide_floating_blur_amount_y = 8.0
    vim.g.neovide_refresh_rate_idle = 5
end

----------------------
---- Plugin configs --
----------------------

-- JSON Syntax
vim.g.vim_json_syntax_conceal = 0  -- Don't hide quotes in JSON files

-- EditorConfig
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}

-- Load plugins and configs --
require 'plugins'

-- Load Keymap --
require 'mappings'
