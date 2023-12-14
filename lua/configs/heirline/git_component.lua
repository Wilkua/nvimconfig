local icons = require 'configs.heirline.icons'
local conditions = require 'heirline.conditions'

local git_repo_component = {
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
    end,
    provider = function(self)
        return icons.git_branch .. ' ' .. self.status_dict.head
    end,
    hl = { fg = 'orange' },
}

local git_status_component = {
    condition = function()
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

return {
    condition = conditions.is_git_repo,

    git_repo_component,
    git_status_component,
}
