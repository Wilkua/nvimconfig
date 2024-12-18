return {
    {
        'windwp/nvim-ts-autotag',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            opts = {
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = false
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        cmd = {
            'TSBufDisable', 'TSBufEnable', 'TSBufToggle',
            'TSDisable', 'TSEnable', 'TSToggle',
            'TSInstall', 'TSInstallInfo', 'TSInstallSync',
            'TSModuleInfo', 'TSUninstall', 'TSUpdate',
            'TSUpdateSync',
        },
        opts = {
            ensure_installed = {
                'c', 'html', 'java', 'javascript', 'json', 'lua',
                'rust', 'typescript', 'vim', 'vimdoc',
            },
            sync_install = false,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            context_commentstring = { enable = true },
            incremental_selection = { enable = true },
        },
        init = function()
            vim.g.skip_ts_context_commentstring_module = true
        end,
        config = function(_, opts)
            require 'nvim-treesitter'
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
