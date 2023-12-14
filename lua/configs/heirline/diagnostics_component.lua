local icons = require 'configs.heirline.icons'
local conditions = require 'heirline.conditions'

return {
    condition = conditions.has_diagnostics,
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { 'BufEnter', 'DiagnosticChanged' },
    {
        provider = function(self)
            return self.hints > 0 and (icons.diag_tip .. ' ' .. self.hints .. ' ')
        end,
        hl = { fg = 'StatusDiagHint' },
    },
    {
        provider = function(self)
            return self.infos > 0 and (icons.diag_info .. ' ' .. self.infos .. ' ')
        end,
        hl = { fg = 'StatusDiagInfo' },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (icons.diag_warn .. ' ' .. self.warnings .. ' ')
        end,
        hl = { fg = 'StatusDiagWarn' },
    },
    {
        provider = function(self)
            return self.errors > 0 and (icons.diag_error .. ' ' .. self.errors .. ' ')
        end,
        hl = { fg = 'StatusDiagError' },
    }
}

