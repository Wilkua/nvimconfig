return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets'},
        opts = {
            history = true,
            delete_check_events = 'TextChanged',
            region_check_events = 'CursorMoved',
        },
        config = require 'configs.luasnip',
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
        },
        event = { 'InsertEnter' },
        config = require 'configs.nvim-cmp',
    },
}
