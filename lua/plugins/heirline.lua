return {
    'rebelot/heirline.nvim',
    tag = 'stable',
    event = { 'UiEnter' },
    config = function()
        require 'configs.heirline'
    end,
}