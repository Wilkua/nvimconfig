return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind.nvim',
        'L3MON4D3/LuaSnip',
    },
    events = { 'InsertEnter' },
    config = function() require 'configs.nvim-cmp' end,
}
