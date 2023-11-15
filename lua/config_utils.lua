return {
    noremap = function (mode, lhs, rhs, opts)
        local opts = opts or {}
        if opts['noremap'] == nil then opts['noremap'] = true end
        vim.keymap.set(mode, lhs, rhs, opts)
    end,
}
