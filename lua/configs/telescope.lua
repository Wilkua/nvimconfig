local tele = require 'telescope'
tele.setup {
    defaults = {
        selection_caret = '❯ ',
        path_display = { 'truncate' },
        file_ignore_patterns = {'node_modules'},
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
            vertical = {
                prompt_position = 'top',
                width = 0.5,
            },
        },
        preview = false,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        }
    }
}

-- Aerial configuration
require('aerial').setup {}

-- Telescope extensions
tele.load_extension 'aerial'

local ok, _ = pcall(require, 'nvim-notify')
if ok then
    tele.load_extension 'notify'
end

-- There's no good way to detect if this plugin is available,
-- so just make sure it's installed. Alternatively, just disable
-- this part alltogether.
if vim.fn.has 'win32' == 1 then
    tele.load_extension 'fzy_native'
else
    tele.load_extension 'fzf'
end

