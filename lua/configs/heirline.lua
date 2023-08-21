local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local colors = {
    StatusBrightBG = utils.get_highlight('Folded').bg,
    StatusBrightFG = utils.get_highlight('Folded').fg,

    StatusDiagError = utils.get_highlight('DiagnosticError').fg,
    StatusDiagHint = utils.get_highlight('DiagnosticHint').fg,
    StatusDiagInfo = utils.get_highlight('DiagnosticInfo').fg,
    StatusDiagWarn = utils.get_highlight('DiagnosticWarn').fg,
    StatusFileName = utils.get_highlight('Directory').fg,
    StatusGitRemoved = utils.get_highlight('diffRemoved').fg,
    StatusGitAdded = utils.get_highlight('diffAdded').fg,
    StatusGitChanged = utils.get_highlight('diffChanged').fg,
    StatusModeC = utils.get_highlight('Constant').fg,
    StatusModeI = utils.get_highlight('DiagnosticError').fg,
    StatusModeN = utils.get_highlight('String').fg,
    StatusModeR = utils.get_highlight('Constant').fg,
    StatusModeS = utils.get_highlight('Statement').fg,
    StatusModeT = utils.get_highlight('NonText').fg,
    StatusModeV = utils.get_highlight('Special').fg,
    StatusModeSpecial = utils.get_highlight('NonText').fg,
    -- Basic color choices
    StatusRed = utils.get_highlight('DiagnosticError').fg,
    StatusDarkRed = utils.get_highlight('DiffDelete').bg,
    StatusGreen = utils.get_highlight('String').fg,
    StatusBlue = utils.get_highlight('Function').fg,
    StatusGray = utils.get_highlight('NonText').fg,
    StatusYellow = utils.get_highlight('DiagnosticWarn').fg,
    StatusOrange = utils.get_highlight('Constant').fg,
    StatusPurple = utils.get_highlight('Statement').fg,
    StatusCyan = utils.get_highlight('Special').fg,
}

local mode_component = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    static = {
        mode_names = {
            n = 'N', no = 'N?', nov = 'N?',
            noV = 'N?', ["no\22"] = 'N?', niI = 'Ni',
            niR = 'Nr', niV = 'Nv', nt = 'Nt',

            v = 'V', vs = 'Vs', V = 'V_',
            Vs = 'Vs', ["\22"] = '^V', ["\22s"] = '^V',

            s = 'S', S = 'S_', ["\19"] = '^S',

            i = 'I', ic = 'Ic', ix = 'Ix',

            R = 'R', Rc = 'Rc', Rx = 'Rx',
            Rv = 'Rv', Rvc = 'Rv', Rvx = 'Rv',

            c = 'C', cv = 'Ex',

            r = '...',
            rm = 'M',
            ["r?"] = '?',
            ["!"] = '!',
            t = 'T',
        },
        mode_colors = {
            n = 'StatusModeN' ,
            i = 'StatusModeI',
            v = 'StatusModeV',
            V =  'StatusModeV',
            ["\22"] =  'StatusModeV',
            c =  'StatusModeC',
            s =  'StatusModeS',
            S =  'StatusModeS',
            ["\19"] =  'StatusModeS',
            R =  'StatusModeR',
            r =  'StatusModeR',
            ['!'] =  'StatusModeSpecial',
            t =  'StatusModeT',
        }
    },
    provider = function(self)
        return ' %-2('..self.mode_names[self.mode]..'%)'
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = self.mode_colors[mode], bold = true, }
    end,
    update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
            vim.cmd 'redrawstatus'
        end),
    },
}

local file_info_component = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local file_icon_component = {
    condition = function(self)
        local ok, _ = pcall(require, 'nvim-web-devicons')
        return ok
    end,
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local file_name_component = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ':.')
        if filename == '' then return '[No Name]' end

        if not conditions.width_percent_below(#filename, 0.35) then
            filename = vim.fn.fnamemodify(self.filename, ':t')
        end
        return filename
    end,
    hl = { fg = 'StatusFileName' },
}

local file_flags_component = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = '',
        hl = { fg = 'StatusPurple' },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = '',
        hl = { fg = 'StatusOrange' },
    },
}

local file_name_modifier = {
    hl = function()
        if vim.bo.modified then
            return { fg = 'StatusPurple', force = true }
        end
    end,
}

file_info_component = utils.insert(file_info_component,
    file_icon_component,
    { provider = '%<' },
    utils.insert(file_name_modifier, file_name_component),
    file_flags_component,
    { provider = ' ' }
)

local file_type_component = {
    provider = function()
        return string.upper(vim.bo.filetype) .. ' '
    end,
}

local file_encoding_component = {
    { -- icon for fileformat
        provider = function()
            if vim.bo.fileformat == 'unix' then
                return ' '
            end

            return '󰨡 '
        end,
        hl = { fg = 'StatusBlue' }
    },
    { -- encoding
        provider = function()
            return (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
        end,
        hl = { fg = 'StatusBlue' }
    },
    { provider = ' ' }
}

local git_repo_component = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    provider = function(self)
        return ' ' .. self.status_dict.head .. ' '
    end,
    hl = { fg = 'orange' },
}

local git_status_component = {
    condition = function(self)
        if conditions.is_git_repo() then
            local status_dict = vim.b.gitsigns_status_dict
            local has_changes = status_dict.added ~= 0 or status_dict.removed ~= 0 or status_dict.changed ~= 0
            return has_changes
        end
        return false
    end,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (' ' .. count .. ' ')
        end,
        hl = { fg = 'StatusGitAdded' },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (' ' .. count .. ' ')
        end,
        hl = { fg = 'StatusGitChanged' },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (' ' .. count .. ' ')
        end,
        hl = { fg = 'StatusGitRemoved' },
    },
}

local diagnostics_component = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = ' ',
        warn_icon = ' ',
        info_icon = ' ',
        hint_icon = ' ',
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.infos = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    update = { 'BufEnter', 'DiagnosticChanged' },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints .. ' ')
        end,
        hl = { fg = 'StatusDiagHint' },
    },
    {
        provider = function(self)
            return self.infos > 0 and (self.info_icon .. self.infos .. ' ')
        end,
        hl = { fg = 'StatusDiagInfo' },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
        end,
        hl = { fg = 'StatusDiagWarn' },
    },
    {
        provider = function(self)
            return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
        end,
        hl = { fg = 'StatusDiagError' },
    }

}

local macro_info_component = {
    condition = function()
        return vim.fn.reg_recording() ~= ''
    end,
    provider = ' ',
    hl = { fg = 'StatusOrange' },
    utils.surround({ '󰜴', ' ' }, nil, {
        provider = function()
            return vim.fn.reg_recording()
        end,
        hl = { fg = 'StatusOrange' },
    }),
    update = {
        'RecordingEnter',
        'RecordingLeave',
     }
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

local helpfile_name_component = {
    condition = function()
        return vim.bo.filetype == 'help'
    end,
    provider = function()
        local fname = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(fname, ':t')
    end,
    hl = { fg = 'StatusFileName' },
}

local filler_component = { provider = '%=' }

local help_statusline = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { 'help', 'nofile', 'prompt', 'quickfix' },
            filetype = { '^git.*', 'fugitive' },
        })
    end,

    file_type_component,
   helpfile_name_component,
   filler_component,
}

local main_statusline = {
    hl = function()
        if conditions.is_active() then
            return 'StatusLine'
        end
        return 'StatusLineNC'
    end,

    utils.surround({ '', ' ' }, 'StatusBrightBG', { mode_component }),
    git_repo_component,
    file_info_component,
    git_status_component,
    diagnostics_component,
    filler_component,
    macro_info_component,
    file_type_component,
    file_encoding_component,
    scroll_component,
}

require('heirline').setup {
    opts = {
        colors = colors,
    },
    statusline = {
        fallthrough = false,

        help_statusline,
        main_statusline,
    },
}
