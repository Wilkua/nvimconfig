return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'folke/neoconf.nvim',
            cmd = 'Neoconf',
            config = true,
        },
        { 'folke/neodev.nvim', opts = {} },
        'mason.nvim',
        {
            'williamboman/mason-lspconfig.nvim',
            cmd = { 'LspInstall', 'LspUninstall' },
            config = true,
        },
    },
    config = require 'configs.nvim-lspconfig',
}
