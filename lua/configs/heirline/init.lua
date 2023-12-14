local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'
local icons = require 'configs.heirline.icons'

local diagnostics_component = require 'configs.heirline.diagnostics_component'
local git_component = require 'configs.heirline.git_component'
local mode_component = require 'configs.heirline.mode_component'
local ruler_component = require 'configs.heirline.ruler_component'

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

    -- Mode colors
    StatusModeC = utils.get_highlight('Constant').fg,
    StatusModeI = utils.get_highlight('Identifier').fg,
    StatusModeN = utils.get_highlight('Number').fg,
    StatusModeR = utils.get_highlight('DiagnosticError').fg,
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

local file_info_component = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local file_icon_component = {
    condition = function()
        local ok, _ = pcall(require, 'nvim-web-devicons')
        return ok
    end,
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ':e')
        self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. ' ') or ''
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
                return icons.logo_bsd .. ' '
            end

            return icons.logo_win9x .. ' '
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

local space_component = { provider = ' ' }
local main_statusline = {
    hl = function()
        if conditions.is_active() then
            return 'StatusLine'
        end
        return 'StatusLineNC'
    end,

    { provider = icons.drawing.bar_half, hl = { fg = 'StatusBlue' } },
    space_component,
    mode_component,
    space_component,
    git_component,
    file_info_component,
    diagnostics_component,
    filler_component,
    macro_info_component,
    file_type_component,
    file_encoding_component,
    space_component,
    ruler_component,
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
