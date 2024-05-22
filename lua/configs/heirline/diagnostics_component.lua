local icons = require 'configs.heirline.icons'

return {
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    end,
    update = { 'BufEnter', 'BufLeave', 'DiagnosticChanged' },
    {
        provider = function(self)
            return  icons.diag_warn .. ' ' .. self.warnings
        end,
        hl = { fg = 'StatusDiagWarn' },
    },
    { provider = ' ' },
    {
        provider = function(self)
            return icons.diag_error .. ' ' .. self.errors
        end,
        hl = { fg = 'StatusDiagError' },
    }
}
