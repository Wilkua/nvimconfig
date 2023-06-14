local noremap = function (mode, lhs, rhs, opts)
    local opts = opts or {}
    if opts['noremap'] == nil then opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, opts)
end

local resession = require 'resession'

resession.setup()

noremap('n', '<leader>ss', resession.save, { desc = 'Save session' })
noremap('n', '<leader>sl', resession.load, { desc = 'Load session' })
noremap('n', '<leader>sd', resession.delete, { desc = 'Delete session' })
