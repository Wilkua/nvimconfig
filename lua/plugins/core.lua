return {
    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        init = function()
            vim.cmd [[syntax on]]
            vim.g.background = 'dark'
            vim.cmd [[colorscheme carbonfox]]
        end,
    },
    { 'folke/tokyonight.nvim', version = '*', priority = 1000 },
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    { 'rose-pine/neovim', name = 'rose-pine', priority = 1000 },

    'folke/lazy.nvim',

    {
        'windwp/nvim-autopairs',
        opts = { check_ts = true },
        config = function(_, opts)
            local ap = require 'nvim-autopairs'
            ap.setup(opts)

            local ok, cmp = pcall(require, 'cmp')
            if ok then
                cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done { tex = false })
            end
        end,
    },

    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            height = 15,
        },
    },

    {
        'gbprod/yanky.nvim',
        opts = {},
        keys = {
            { '<leader>p', function() require('telescope').extensions.yank_history.yank_history({ }) end, desc = 'Open Yank History' },
            { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
            { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
            { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
            { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
            { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },
            { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Select previous entry through yank history' },
            { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Select next entry through yank history' },
            { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
            { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
            { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
            { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
            { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and indent right' },
            { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and indent left' },
            { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put before and indent right' },
            { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put before and indent left' },
            { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
            { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },
        },
    },

    {
        'rebelot/heirline.nvim',
        tag = 'stable',
        event = { 'UiEnter' },
        config = function() require 'configs.heirline' end,
    },

    {
        'akinsho/toggleterm.nvim',
        version = '*',
        cmd = { 'ToggleTerm', 'TermExec' },
        opts = {
            size = 25,
            shell = vim.o.shell == 'cmd.exe' and 'pwsh.exe' or vim.o.shell,
        },
    },

    { 'rcarriga/nvim-notify', init = function() vim.notify = require 'notify' end },
    {'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' }},
    { 'williamboman/mason.nvim', config = true },
    { 'numToStr/Comment.nvim', config = true },
    { 'lewis6991/gitsigns.nvim', config = true },
    { 'stevearc/resession.nvim', config = true },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    'editorconfig/editorconfig-vim',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',
}
