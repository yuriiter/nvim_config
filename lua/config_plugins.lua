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
