return {
    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        init = function()
            vim.cmd [[syntax on]]
            vim.g.background = 'dark'
            vim.cmd [[colorscheme nightfox]]
        end,
    },

    "nvim-lua/plenary.nvim",
    'stevearc/dressing.nvim',
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
    { 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings() end },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = { disable = { filetypes = { "TelescopePrompt" } } },
    },
    {'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' }},
    { 'NvChad/nvim-colorizer.lua', config = true },

    'editorconfig/editorconfig-vim',
    'tpope/vim-fugitive',
    'tpope/vim-jdaddy',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'tpope/vim-unimpaired',
    {'ludovicchabant/vim-gutentags', enabled = vim.fn.executable 'ctags' == 1 },
    'wellle/targets.vim',
}
