local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local output = vim.fn.system({
        "git", "clone",
        "--filter=blob:none",
        "--branch=stable", -- latest stable release
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
    if vim.api.nvim_get_vvar "shell_error" ~= 0 then
        vim.api.nvim_err_writeln("Error cloning lazy.nvim repository...\n\n" .. output)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')