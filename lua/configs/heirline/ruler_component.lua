local icons = require 'configs.heirline.icons'

local colnum_component = {
    provider = icons.column_number .. '%c',
    hi = function() if vim.fn.virtcol('.') >= 80 then return 'DiagnosticError' else return 'Text' end end,
}

local linenum_component = {
    provider = icons.line_number .. '%l',
}

local scroll_component = {
    static = {
        bits = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
    },
    provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.bits) + 1
        return '%P ' .. string.rep(self.bits[i], 2)
    end,
    hl = { bg = 'StatusBrightBG' },
}

return {
    linenum_component,
    { provider = icons.drawing.slant_left },
    colnum_component,
    { provider = ' ' },
    scroll_component,
}
