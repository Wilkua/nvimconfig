local noremap = function (mode, lhs, rhs, opts)
    local opts = opts or {}
    if opts['noremap'] == nil then opts['noremap'] = true end
    vim.keymap.set(mode, lhs, rhs, opts)
end

noremap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostics', silent = true })
noremap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic', silent = true })
noremap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic', silent = true })
noremap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Set loclist', silent = true })

local on_attach = function (client, bufnr)
    noremap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration', silent = true, buffer = bufnr })
    noremap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition', silent = true, buffer = bufnr })
    noremap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover info', silent = true, buffer = bufnr })
    noremap('n', 'gi', vim.lsp.buf.implementation, { desc = 'List implementations', silent = true, buffer = bufnr })
    noremap({'n', 'i'}, '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help', silent = true, buffer = bufnr })
    noremap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder', silent = true, buffer = bufnr })
    noremap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder', silent = true, buffer = bufnr })
    noremap('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = 'List workspace folders', silent = true, buffer = bufnr })
    noremap('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Show type definition', silent = true, buffer = bufnr })
    noremap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol', silent = true, buffer = bufnr })
    noremap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Select code action', silent = true, buffer = bufnr })
    noremap('n', 'gr', vim.lsp.buf.references, { desc = 'List references', silent = true, buffer = bufnr })
    noremap('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, { desc = 'Format buffer', silent = true, buffer = bufnr })
end

local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local lsp = require 'lspconfig'

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
lsp.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}


