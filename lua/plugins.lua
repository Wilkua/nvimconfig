function get_config(pkg)
    return string.format('require "configs/%s"', pkg)
end

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'

    use {
        'williamboman/mason.nvim',
        requires = { 'williamboman/mason-lspconfig.nvim' },
        config = get_config 'mason',
    }

    use { 'rcarriga/nvim-notify', config = get_config 'nvim-notify' }

    use 'stevearc/dressing.nvim'

    use {
      'stevearc/resession.nvim',
      config = get_config 'resession'
    }

    use { 'mrjones2014/smart-splits.nvim', tag = 'v1.2.*' }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim',
            'L3MON4D3/LuaSnip',
        },
        config = get_config 'nvim-cmp',
    }

    use {
        'neovim/nvim-lspconfig',
        after = 'cmp-nvim-lsp',
        config = get_config 'nvim-lspconfig',
    }

    use { 'jose-elias-alvarez/null-ls.nvim', config = get_config 'null-ls' }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = get_config 'nvim-treesitter',
    }

    use {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
    }

    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter',
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'stevearc/aerial.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                disable = vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0,
                run = 'make',
            },
            {
                'nvim-telescope/telescope-fzy-native.nvim',
                disable = vim.fn.has 'win32' == 0,
                run = 'git submodules update --init',
            }
        },
        config = get_config 'telescope',
    }

    vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
    use {
        'nvim-neo-tree/neo-tree.nvim',
        cmd = 'Neotree',
        branch = 'v2.x',
        requires = { 
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        }
    }

    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        config = get_config 'nvim-ufo',
    }

    use {
        'rebelot/heirline.nvim',
        event = 'UiEnter',
        config = get_config 'heirline',
    }

    use { 'akinsho/toggleterm.nvim', tag = 'v2.7.*', config = get_config 'toggleterm' }
    use { 'lewis6991/gitsigns.nvim', config = get_config 'gitsigns' }
    use { 'numToStr/Comment.nvim', config = get_config 'comment' }
    use { 'windwp/nvim-autopairs', config = get_config 'nvim-autopairs' }
    use { 'ggandor/leap.nvim', config = get_config 'leap' }
    use { 'folke/which-key.nvim', config = get_config 'which-key' }
    use { 'EdenEast/nightfox.nvim', config = get_config 'nightfox' }
    use {'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' }}
    use { 'NvChad/nvim-colorizer.lua', config = 'require "colorizer".setup()' }

    use 'navarasu/onedark.nvim'
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-jdaddy'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use {'ludovicchabant/vim-gutentags', disable = vim.fn.executable 'ctags' == 0 }
    use 'wellle/targets.vim'

    if packer_bootstrap then
        require('packer').sync()
    end
end,
config = {
    profile = {
        enable = false,
        threshold = 10,
    },
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'single' }
        end,
    },
}})
