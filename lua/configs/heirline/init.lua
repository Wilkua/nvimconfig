local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local colors = require 'configs.heirline.colors'
local icons = require 'configs.heirline.icons'

local diagnostics_component = require 'configs.heirline.diagnostics_component'
local file_info_component = require 'configs.heirline.file_info_component'
local git_component = require 'configs.heirline.git_component'
local mode_component = require 'configs.heirline.mode_component'
local ruler_component = require 'configs.heirline.ruler_component'

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
    provider = icons.circle_dot_o .. ' ',
    hl = { fg = 'StatusOrange' },
    utils.surround({ icons.drawing.arrow_right, ' ' }, nil, {
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
    space_component,
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
