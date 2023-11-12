return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require 'nvim-treesitter'
        require('nvim-treesitter.configs').setup {
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
    end,
}