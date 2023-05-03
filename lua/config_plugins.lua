local utils = require("utils")

if utils.isModuleAvailable("telescope") then
    require('telescope').setup({
        defaults = {
            layout_config = {
                vertical = { width = 0.5 }
            },
        },
    })
end

if utils.isModuleAvailable("nvim-treesitter") then
    require'nvim-treesitter.configs'.setup {
        highlight = { enable = true },
        indent = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
        autotag = {
            enable = true,
        },
        ensure_installed = {
            "bash",
            "c",
            "html",
            "javascript",
            "json",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        },
        auto_install = true,
    }
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    -- parser_config.
end

if utils.isModuleAvailable("mini.pairs") then
    require'mini.pairs'.setup {
    }
end

if utils.isModuleAvailable("mason") then
    require'mason'.setup {
    }
end
if utils.isModuleAvailable("mason") then
    require("mason-lspconfig").setup({
        ensure_installed = {
            "asm_lsp",
            "bashls",
            "clangd",
            "cmake",
            "cssls",
            "cssmodules_ls",
            "diagnosticls",
            "dockerls",
            "docker_compose_language_service",
            "eslint",
            "emmet_ls",
            "graphql",
            "html",
            "jsonls",
            "tsserver",
            "lua_ls",
            "prismals",
            "pyright",
            "rust_analyzer",
            "sqlls",
            "solidity",
            "stylelint_lsp",
            "tailwindcss",
            "tsserver",
            "vimls",
            "yamlls"
        }
    })
end


if utils.isModuleAvailable("nvim-treesitter") then
    require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = false,
        dim_inactive = {
            enabled = false,
            shade = "dark",
            percentage = 0.15,
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            notify = false,
            mini = false,
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin"
end




if utils.isModuleAvailable("mini.comment") then
    require'mini.comment'.setup {
    }
end

if utils.isModuleAvailable("mini.comment") then
    require'mini.comment'.setup {
    }
end

if utils.isModuleAvailable("leap") then
    require('leap').add_default_mappings()
end



-- if utils.isModuleAvailable("lspkind") then
--     local lspkind = require('lspkind')
--     cmp.setup {
--         formatting = {
--             format = lspkind.cmp_format({
--                 mode = 'symbol',
--                 maxwidth = 50,
--                 ellipsis_char = '...',
--
--                 before = function (entry, vim_item)
--                     return vim_item
--                 end
--             })
--         }
--     }
-- end


vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

if utils.isModuleAvailable("luasnip.loaders.from_vscode") then
    require('luasnip.loaders.from_vscode').lazy_load()
end

if utils.isModuleAvailable("cmp") and utils.isModuleAvailable("luasnip") then
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local select_opts = {behavior = cmp.SelectBehavior.Select}

    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'path' },
            { name = 'nvim_lsp', keyword_length = 1 },
            { name = 'buffer', keyword_length = 3 },
            { name = 'luasnip', keyword_length = 2, priority = 100 }, -- Set higher priority for Luasnip
        },
        window = {
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            fields = { 'menu', 'abbr', 'kind' },
            format = function(entry, item)
                local menu_icon = {
                    nvim_lsp = 'λ',
                    luasnip = '⋗',
                    buffer = 'Ω',
                    path = '🖫',
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
            ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<C-f>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-b>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },
    })
end

if utils.isModuleAvailable("lsp_signature") then
    require "lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded"
        }
    })
end

if utils.isModuleAvailable("vim-jsx-pretty") then
    require "vim-jsx-pretty".setup({ })
end
