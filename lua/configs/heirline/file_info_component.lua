local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'

local icons = require 'configs.heirline.icons'

local file_info_component = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
    update = { 'BufFilePost', 'BufReadPost', 'BufWritePost' },
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
        provider = icons.circle_small,
        hl = { fg = 'StatusPurple' },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = icons.padlock,
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

return utils.insert(file_info_component,
    file_icon_component,
    { provider = '%<' },
    utils.insert(file_name_modifier, file_name_component),
    file_flags_component,
    { provider = ' ' }
)

