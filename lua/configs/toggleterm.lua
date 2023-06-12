local noremap = function (mode, lhs, rhs, opts)
    local opts = opts or {}
    if opts['noremap'] == nil then opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, opts)
end

require('toggleterm').setup {}

noremap('n', '<leader>t', '<cmd>ToggleTerm direction=float<CR>')

