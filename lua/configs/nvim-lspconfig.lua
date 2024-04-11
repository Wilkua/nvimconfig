return function()
    -- Automatically load mason lsp servers
    require('mason-lspconfig').setup_handlers {
        function(server_name)
            require('lspconfig')[server_name].setup {}
        end,
    }
end
