local utils = require 'heirline.utils'

return {
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
