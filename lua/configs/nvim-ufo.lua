local noremap = function (mode, lhs, rhs, opts)
    local opts = opts or {}
    if opts['noremap'] == nil then opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, opts)
end

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local ufo = require 'ufo'

noremap('n', 'zR', ufo.openAllFolds)
noremap('n', 'zM', ufo.closeAllFolds)

ufo.setup {
    provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
    end,
}
