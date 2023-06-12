local noremap = function (mode, lhs, rhs, opts)
    local opts = opts or {}
    if opts['noremap'] == nil then opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, opts)
end

local tele_builtin = require('telescope.builtin')

noremap('n', '<leader>ff', tele_builtin.find_files, { desc = 'Find file ...' })
noremap('n', '<leader>fg', tele_builtin.live_grep, { desc = 'Live grep ...' })
noremap('n', '<leader>fb', tele_builtin.buffers, { desc = 'Find buffer ...' })
noremap('n', '<leader>fh', tele_builtin.help_tags, { desc = 'Find help tag ...' })

local tele = require 'telescope'
tele.setup {
    defaults = {
        selection_caret = '->',
        path_display = { 'truncate' },
        file_ignore_patterns = {'node_modules'},
        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        layout_strategy = 'horizontal',
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

