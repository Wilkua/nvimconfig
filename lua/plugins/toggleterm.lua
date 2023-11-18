return {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec' },
    opts = {
        size = 30,
        shell = vim.o.shell == 'cmd.exe' and 'pwsh.exe' or vim.o.shell,
    },
}
