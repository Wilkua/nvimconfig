-- Speed up lua loading
-- Neovim 0.9+
vim.loader.enable()

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
noremap('n', '<leader>l', ':set list!<CR>', { desc = 'Toggle unprintable chars', silent = true })

-- Clear search highlighting
noremap('n', '<esc>', ':noh<cr>', { desc = 'Clear search hilight', silent = true })

-- Quick upper- and lowercase word conversion
noremap('n', '<leader>U', 'gUiw', { desc = 'Uppercase whole word' })
noremap('n', '<leader>u', 'guiw', { desc = 'Lowercase whole word' })

-- Don't use Ex mode, use Q for formatting
vim.keymap.set('n', 'Q', 'gq', { desc = 'Format with motion' })

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
set.fileformat = 'unix'              -- Always use Unix line endings
set.laststatus = 2                   -- Set the status line to have 2 rows
set.scrolloff = 5                    -- Always keep three lines below the cursor when scrolling
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

function get_config(pkg)
    return string.format('require "configs/%s"', pkg)
end

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'williamboman/mason.nvim',
        requires = { 'williamboman/mason-lspconfig.nvim' },
        config = get_config 'mason',
    }

    use { 'rcarriga/nvim-notify', config = get_config 'nvim-notify' }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
        config = get_config 'nvim-cmp',
    }

    use {
        'neovim/nvim-lspconfig',
        after = 'cmp-nvim-lsp',
        config = get_config 'nvim-lspconfig',
    }

    use { 'jose-elias-alvarez/null-ls.nvim', config = get_config 'null-ls' }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = get_config 'nvim-treesitter',
    }

    use {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
    }

    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter',
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'stevearc/aerial.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                enabled = vim.fn.has 'win32' == 0 and vim.fn.executable 'make',
                run = 'make',
            },
            {
                'nvim-telescope/telescope-fzy-native.nvim',
                enabled = vim.fn.has 'win32' == 1,
                run = 'git submodules update --init',
            }
        },
        config = get_config 'telescope',
    }

    vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
    use {
        'nvim-neo-tree/neo-tree.nvim',
        cmd = 'Neotree',
        branch = 'v2.x',
        requires = { 
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        }
    }

    use { 'akinsho/toggleterm.nvim', config = get_config 'toggleterm' }
    use { 'lewis6991/gitsigns.nvim', config = get_config 'gitsigns' }
    use { 'numToStr/Comment.nvim', config = get_config 'comment' }
    use { 'windwp/nvim-autopairs', config = get_config 'nvim-autopairs' }
    use { 'ggandor/leap.nvim', config = get_config 'leap' }
    use { 'folke/which-key.nvim', config = get_config 'which-key' }
    use { 'EdenEast/nightfox.nvim', config = get_config 'nightfox' }

    use 'navarasu/onedark.nvim'
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-jdaddy'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'ludovicchabant/vim-gutentags'
    use 'wellle/targets.vim'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
