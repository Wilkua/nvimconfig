-- Key Mappings

-- Map keys with "remap = true" by default
local noremap = function (mode, lhs, rhs, opts)
    local opts = opts or {}
    if opts['noremap'] == nil then opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Set arrow keys to move between windows
noremap('n', '<up>', '<c-w>k')
noremap('n', '<down>', '<c-w>j')
noremap('n', '<left>', '<c-w>h')
noremap('n', '<right>', '<c-w>l')

-- Use shift + arrow keys to move windows around
noremap('n', '<s-up>', '<c-w><s-k>')
noremap('n', '<s-down>', '<c-w><s-j>')
noremap('n', '<s-left>', '<c-w><s-h>')
noremap('n', '<s-right>', '<c-w><s-l>')

-- Cancel insert, move windows, start insert
noremap('i', '<up>', '<esc><c-w>ka')
noremap('i', '<down>', '<esc><c-w>ja')
noremap('i', '<left>', '<esc><c-w>ha')
noremap('i', '<right>', '<esc><c-w>la')

-- Shortcut to rapidly toggle 'set list'
noremap('n', '<leader>l', ':set list!<CR>', { desc = 'Toggle unprintable chars', silent = true })

-- Clear search highlighting
noremap('n', '<esc>', ':noh<cr>', { desc = 'Clear search hilight', silent = true })

-- Quick upper- and lowercase word conversion
noremap('n', '<leader>U', 'gUiw', { desc = 'Uppercase whole word' })
noremap('n', '<leader>u', 'guiw', { desc = 'Lowercase whole word' })

-- Don't use Ex mode, use Q for formatting
vim.keymap.set('n', 'Q', 'gq', { desc = 'Format with motion' })

-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
noremap('i', '<c-u>', '<c-g>u<c-U>')

-- Center the line moved to with G
noremap('n', 'G', 'Gzz')

-- Center the found search item
noremap('n', 'n', 'nzz')

-- Faster screen movement
noremap('n', '<c-e>', '5<c-e>')
noremap('n', '<c-y>', '5<c-y>')

-- Faster saving
noremap('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
noremap('n', '<leader>W', '<cmd>w!<CR>', { desc = 'Force save file' })

local is_ok, aerial = pcall(require, 'aerial')
if is_ok then
    noremap('n', '<leader>o', aerial.toggle, { desc = 'Toggle symbol outline' })
end

local is_ok, gitsigns = pcall(require, 'gitsigns')
if is_ok then
    noremap('n', ']g', gitsigns.next_hunk, { desc = 'Next Git hunk' })
    noremap('n', '[g', gitsigns.prev_hunk, { desc = 'Previous Git hunk' })
    noremap('n', '<leader>gl', gitsigns.blame_line, { desc = 'Git blame line' })
    noremap('n', '<leader>gL', function() gitsigns.blame_line { full = true } end, { desc = 'Full Git blame' })
end

local is_ok, resession = pcall(require, 'resession')
if is_ok then
    noremap('n', '<leader>ss', resession.save, { desc = 'Save session' })
    noremap('n', '<leader>sl', resession.load, { desc = 'Load session' })
    noremap('n', '<leader>sd', resession.delete, { desc = 'Delete session' })
end

-- Telescope mappings
local is_ok, tele_builtin = pcall(require, 'telescope.builtin')
if is_ok then
    noremap('n', '<leader>ff', tele_builtin.find_files, { desc = 'Find file' })
    noremap('n', '<leader>fF', function() tele_builtin.find_files { hidden = true, no_ignore = true } end, { desc = 'Find all files' })
    noremap('n', '<leader>fg', tele_builtin.live_grep, { desc = 'Live grep' })
    noremap('n', '<leader>fb', tele_builtin.buffers, { desc = 'Find buffer' })
    noremap('n', '<leader>fh', tele_builtin.help_tags, { desc = 'Find help tag' })
    noremap('n', '<leader>fr', tele_builtin.registers, { desc = 'Vim registers' })
    noremap('n', "<leader>f'", tele_builtin.marks, { desc = 'Marks' })

    noremap('n', '<leader>gb', tele_builtin.git_branches, { desc = 'Git branches' })
    noremap('n', '<leader>gc', tele_builtin.git_commits, { desc = 'Git commits' })
    noremap('n', '<leader>gs', tele_builtin.git_status, { desc = 'Git status' })

    local ok, _ = pcall(require, "aerial")
    if ok then
        noremap('n', '<leader>ls', require('telescope').extensions.aerial.aerial, { desc = 'Find symbol' })
    end
end

local ok, ufo = pcall(require, 'ufo')
if ok then
    noremap('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
    noremap('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
    noremap('n', 'zp', ufo.peekFoldedLinesUnderCursor, { desc = 'Peek fold contents' })
end
