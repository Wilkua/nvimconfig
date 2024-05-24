local icons = require 'configs.heirline.icons'
local conditions = require 'heirline.conditions'

local git_branch_component = {
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    provider = function(self)
        return icons.git_branch .. ' ' .. self.status_dict.head
    end,
    hl = { fg = 'orange' },
}

return {
    condition = conditions.is_git_repo,
    update = {
        'BufEnter',
        'BufFilePost',
        'BufLeave',
        'BufReadPost',
        'BufWritePost',

        callback = vim.schedule_wrap(function()
            vim.cmd 'redrawstatus'
        end),
    },

    git_branch_component,
}
