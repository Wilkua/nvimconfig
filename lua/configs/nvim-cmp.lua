return function()
    local cmp = require 'cmp'
    local snip_ok, luasnip = pcall(require, 'luasnip')
    local lspkind = require 'lspkind'
    if not snip_ok then return end


    lspkind.init {
        mode = 'symbol',
        preset = 'codicons',
    }

    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    local pretty_border = {
        border = 'rounded',
        winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
    }

    cmp.setup {
        formatting = {
            format = lspkind.cmp_format {
                mode = 'symbol',
                maxwidth = 50,
                ellipsis_char = '...',
            },
            fields = { 'kind', 'abbr', 'menu' },
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(pretty_border),
            documentation = cmp.config.window.bordered(pretty_border),
        },
        mapping = cmp.mapping.preset.insert({
            ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
            ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
            ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-3), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(3), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable,
            ['<C-e>'] = cmp.mapping {
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            },
            ['<CR>'] = cmp.mapping.confirm { select = false },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                -- elseif luasnip.expandable() then
                --     luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { 'i',  's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        preselect = cmp.PreselectMode.None,
        sources = cmp.config.sources {
            { name = 'nvim_lsp', priority = 1000 },
            { name = 'luasnip', priority = 800 },
            { name = 'buffer', priority = 600 },
            { name = 'path', priority = 400 },
            { name = 'nvim_lua', priority = 200 },
        },
    }

    -- CMP file types
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end
