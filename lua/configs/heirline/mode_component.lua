local icons = require 'configs.heirline.icons'
local utils = require 'heirline.utils'

return {
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
    update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
            vim.cmd 'redrawstatus'
        end),
    },
    provider = function(self)
        return self.mode_names[self.mode]
    end,
    hl = function(self)
        self.color = self.mode_colors[self.mode:sub(1, 1)]
        return { fg = self.color, bg = 'Background', bold = true }
    end
}
