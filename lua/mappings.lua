-- Key Mappings

-- Map keys with "remap = true" by default
local noremap = function (mode, lhs, rhs, opts)
    local key_opts = opts or {}
    if key_opts['noremap'] == nil then key_opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, key_opts)
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
noremap({'n', 'v'}, '<c-e>', "v:count == 0 ? '5<c-e>' : '<c-e>'", { expr = true })
noremap({'n', 'v'}, '<c-y>', "v:count == 0 ? '5<c-y>' : '<c-y>'", { expr = true })

-- Other movement improvements
noremap({'n', 'v'}, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
noremap({'n', 'v'}, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Faster saving
noremap('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
noremap('n', '<leader>W', '<cmd>w!<CR>', { desc = 'Force save file' })

-- Aerial mappings
noremap('n', '<leader>o', function() require('aerial').toggle() end, { desc = 'Toggle symbol outline' })

-- Gitsigns mappings
noremap('n', ']g', function() require('gitsigns').next_hunk() end, { desc = 'Next Git hunk' })
noremap('n', '[g', function() require('gitsigns').prev_hunk() end, { desc = 'Previous Git hunk' })
noremap('n', '<leader>gl', function() require('gitsigns').blame_line() end, { desc = 'Git blame line' })
noremap('n', '<leader>gL', function() require('gitsigns').blame_line { full = true } end, { desc = 'Full Git blame' })

-- Resession mappings
noremap('n', '<leader>ss', function() require('resession').save() end, { desc = 'Save session' })
noremap('n', '<leader>sl', function() require('resession').load() end, { desc = 'Load session' })
noremap('n', '<leader>sd', function() require('resession').delete() end, { desc = 'Delete session' })

-- Telescope mappings
noremap('n', '<leader>ff', function()  require('telescope.builtin').find_files() end, { desc = 'Find file' })
noremap('n', '<leader>fF', function() require('telescope.builtin').find_files { hidden = true, no_ignore = true } end, { desc = 'Find all files' })
noremap('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Live grep' })
noremap('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Find buffer' })
noremap('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Find help tag' })
noremap('n', '<leader>fr', function() require('telescope.builtin').registers() end, { desc = 'Vim registers' })
noremap('n', "<leader>f'", function() require('telescope.builtin').marks() end, { desc = 'Marks' })

noremap('n', '<leader>gb', function() require('telescope.builtin').git_branches() end, { desc = 'Git branches' })
noremap('n', '<leader>gc', function() require('telescope.builtin').git_commits() end, { desc = 'Git commits' })
noremap('n', '<leader>gs', function() require('telescope.builtin').git_status() end, { desc = 'Git status' })

-- ToggleTerm mappings
noremap('n', '<leader>tt', '<cmd>ToggleTerm toggle<CR>', { desc = 'Toggle terminal' })
noremap('t', '<leader>tt', '<cmd>ToggleTerm toggle<CR>', { desc = 'Toggle terminal' })

-- Neotree mappings
noremap('n', '<leader>tr', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neotree display' })

-- Trouble mappings
noremap('n', '<leader>xx', function() require('trouble').toggle() end, { desc = 'Open Trouble' })
noremap('n', '<leader>xw', function() require('trouble').toggle('workspace_diagnostics') end, { desc = 'Open Trouble in Workspace mode' })
noremap('n', '<leader>xd', function() require('trouble').toggle('document_diagnostics') end, { desc = 'Open Trouble in Document mode' })
noremap('n', '<leader>xq', function() require('trouble').toggle('quickfix') end, { desc = 'Open Trouble with quickfix items' })
noremap('n', '<leader>xl', function() require('trouble').toggle('loclist') end, { desc = 'Open Trouble with window loclist items' })
-- noremap('n', 'gR', function() require('trouble').toggle('lsp_references') end, { desc = 'Open Trouble with LSP references' })
-- noremap('n', 'gD', function() require('trouble').toggle('lsp_definitions') end, { desc = 'Open Trouble with LSP definitions' })
