return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason-lspconfig.nvim',
            cmd = { 'LspInstall', 'LspUninstall' },
            config = true,
        },
    },
    config = require 'configs.nvim-lspconfig',
}
