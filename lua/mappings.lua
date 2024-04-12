-- Key Mappings

-- Set arrow keys to move between windows
vim.keymap.set('n', '<up>', '<c-w>k')
vim.keymap.set('n', '<down>', '<c-w>j')
vim.keymap.set('n', '<left>', '<c-w>h')
vim.keymap.set('n', '<right>', '<c-w>l')

-- Use shift + arrow keys to move windows around
vim.keymap.set('n', '<s-up>', '<c-w><s-k>')
vim.keymap.set('n', '<s-down>', '<c-w><s-j>')
vim.keymap.set('n', '<s-left>', '<c-w><s-h>')
vim.keymap.set('n', '<s-right>', '<c-w><s-l>')

-- Cancel insert, move windows, start insert
vim.keymap.set('i', '<up>', '<esc><c-w>ka')
vim.keymap.set('i', '<down>', '<esc><c-w>ja')
vim.keymap.set('i', '<left>', '<esc><c-w>ha')
vim.keymap.set('i', '<right>', '<esc><c-w>la')

-- Shortcut to rapidly toggle 'set list'
vim.keymap.set('n', '<leader>l', ':set list!<CR>', { desc = 'Toggle unprintable chars', silent = true })

-- Clear search highlighting
vim.keymap.set('n', '<esc>', ':noh<cr>', { desc = 'Clear search hilight', silent = true })

-- Quick upper- and lowercase word conversion
vim.keymap.set('n', '<leader>U', 'gUiw', { desc = 'Uppercase whole word' })
vim.keymap.set('n', '<leader>u', 'guiw', { desc = 'Lowercase whole word' })

-- Don't use Ex mode, use Q for formatting
vim.keymap.set('n', 'Q', 'gq', { desc = 'Format with motion' })

-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
vim.keymap.set('i', '<c-u>', '<c-g>u<c-U>')

-- Attempt to keep the cursor in the center at all times
vim.keymap.set('n', 'G', 'Gzz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Faster screen movement
vim.keymap.set({'n', 'v'}, '<c-e>', "v:count == 0 ? '5<c-e>' : '<c-e>'", { expr = true })
vim.keymap.set({'n', 'v'}, '<c-y>', "v:count == 0 ? '5<c-y>' : '<c-y>'", { expr = true })

-- Other movement improvements
vim.keymap.set({'n', 'v'}, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({'n', 'v'}, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

vim.keymap.set('n', '[B', ':bfirst<CR>', { desc = 'Go to first buffer' })
vim.keymap.set('n', '[b', ':bprevious<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', ']B', ':blast<CR>', { desc = 'Go to last buffer' })
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '[C', ':cfirst<CR>', { desc = 'Go to first quickfix item' });
vim.keymap.set('n', '[c', ':cprev<CR>', { desc = 'Go to previous quickfix item' });
vim.keymap.set('n', ']C', ':clast<CR>', { desc = 'Go to last quickfix item' })
vim.keymap.set('n', ']c', ':cnext<CR>', { desc = 'Go to next quickfix item' })

-- Faster saving
vim.keymap.set('n', '<leader>w', '<cmd>silent w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>W', '<cmd>silent w!<CR>', { desc = 'Force save file' })

-- Aerial mappings
vim.keymap.set('n', '<leader>o', function() require('aerial').toggle() end, { desc = 'Toggle symbol outline' })

-- Gitsigns mappings
vim.keymap.set('n', ']g', function() require('gitsigns').next_hunk() end, { desc = 'Next Git hunk' })
vim.keymap.set('n', '[g', function() require('gitsigns').prev_hunk() end, { desc = 'Previous Git hunk' })
vim.keymap.set('n', '<leader>gl', function() require('gitsigns').blame_line() end, { desc = 'Git blame line' })
vim.keymap.set('n', '<leader>gL', function() require('gitsigns').blame_line { full = true } end, { desc = 'Full Git blame' })

-- Telescope mappings
vim.keymap.set('n', '<leader>ff', function()  require('telescope.builtin').find_files() end, { desc = 'Find file' })
vim.keymap.set('n', '<leader>fF', function() require('telescope.builtin').find_files { hidden = true, no_ignore = true } end, { desc = 'Find all files' })
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Find buffer' })
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Find help tag' })
vim.keymap.set('n', '<leader>fr', function() require('telescope.builtin').registers() end, { desc = 'Vim registers' })
vim.keymap.set('n', "<leader>f'", function() require('telescope.builtin').marks() end, { desc = 'Marks' })

vim.keymap.set('n', '<leader>gb', function() require('telescope.builtin').git_branches() end, { desc = 'Git branches' })
vim.keymap.set('n', '<leader>gc', function() require('telescope.builtin').git_commits() end, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gs', function() require('telescope.builtin').git_status() end, { desc = 'Git status' })

-- ToggleTerm mappings
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm toggle<CR>', { desc = 'Toggle terminal' })
vim.keymap.set('t', '<leader>tt', '<cmd>ToggleTerm toggle<CR>', { desc = 'Toggle terminal' })

-- Trouble mappings
vim.keymap.set('n', '<leader>xx', function() require('trouble').toggle() end, { desc = 'Open Trouble' })
vim.keymap.set('n', '<leader>xw', function() require('trouble').toggle('workspace_diagnostics') end, { desc = 'Open Trouble in Workspace mode' })
vim.keymap.set('n', '<leader>xd', function() require('trouble').toggle('document_diagnostics') end, { desc = 'Open Trouble in Document mode' })
vim.keymap.set('n', '<leader>xq', function() require('trouble').toggle('quickfix') end, { desc = 'Open Trouble with quickfix items' })
vim.keymap.set('n', '<leader>xl', function() require('trouble').toggle('loclist') end, { desc = 'Open Trouble with window loclist items' })
-- vim.keymap.set('n', 'gR', function() require('trouble').toggle('lsp_references') end, { desc = 'Open Trouble with LSP references' })
-- vim.keymap.set('n', 'gD', function() require('trouble').toggle('lsp_definitions') end, { desc = 'Open Trouble with LSP definitions' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostics', silent = true })
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic', silent = true })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic', silent = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Set loclist', silent = true })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local bufnr = ev.buf
        -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration', silent = true, buffer = bufnr })
        vim.keymap.set('n', 'gD', function () require('telescope.builtin') end, { desc = 'Go to declaration', buffer = bufnr })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition', silent = true, buffer = bufnr })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover info', silent = true, buffer = bufnr })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
            { desc = 'List implementations', silent = true, buffer = bufnr })
        vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help,
            { desc = 'Signature help', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
            { desc = 'Add workspace folder', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
            { desc = 'Remove workspace folder', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = 'List workspace folders', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
            { desc = 'Show type definition', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
            { desc = 'Select code action', silent = true, buffer = bufnr })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'List references', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end,
            { desc = 'Format buffer', silent = true, buffer = bufnr })
        vim.keymap.set('n', '<leader>gca', vim.lsp.buf.code_action, { desc = 'Apply code action', buffer = bufnr })
    end,
})

