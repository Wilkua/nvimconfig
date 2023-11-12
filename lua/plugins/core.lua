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

    { 'stevearc/dressing.nvim' },
    { 'windwp/nvim-ts-autotag' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'windwp/nvim-autopairs', config = true },
    { 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings() end },
    { 'folke/which-key.nvim', config = true },
    {'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' }},
    { 'NvChad/nvim-colorizer.lua', config = true },

    { 'navarasu/onedark.nvim' },
    { 'editorconfig/editorconfig-vim' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-jdaddy' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-unimpaired' },
    {'ludovicchabant/vim-gutentags', enable = vim.fn.executable 'ctags' == 1 },
    { 'wellle/targets.vim' },
}
