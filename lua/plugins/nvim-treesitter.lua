return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
        -- windwp/nvim-ts-autotag/issues/125
        { 'windwp/nvim-ts-autotag', opts = { autotag = { enable_close_on_slash = false } } },
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
            'c', 'lua', 'rust', 'json',
            'html', 'javascript', 'typescript'
        },
        sync_install = false,
        ignore_install = {},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting  = false,
        },
        autotag = { enable = true },
        indent = { enable = true },
        context_commentstring = { enable = true },
        incremental_selection = { enable = true },
    },
    config = function(_, opts)
        require 'nvim-treesitter'
        require('nvim-treesitter.configs').setup(opts)
    end,
}
