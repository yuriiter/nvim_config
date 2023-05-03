local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

nvim_lsp.eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})


local on_attach = function(client, bufnr)

    if utils.isModuleAvailable('nvim-lsp-ts-utils') then
        on_attach = function(client, bufnr)
            local ts_utils = require("nvim-lsp-ts-utils")

            -- defaults
            ts_utils.setup({
                debug = false,
                disable_commands = false,
                enable_import_on_completion = true,

                -- import all
                import_all_timeout = 5000, -- ms
                -- lower numbers = higher priority
                import_all_priorities = {
                    same_file = 1, -- add to existing import statement
                    local_files = 2, -- git files or files with relative path markers
                    buffer_content = 3, -- loaded buffer content
                    buffers = 4, -- loaded buffer names
                },
                import_all_scan_buffers = 100,
                import_all_select_source = false,
                -- if false will avoid organizing imports
                always_organize_imports = true,

                -- filter diagnostics
                filter_out_diagnostics_by_severity = {},
                filter_out_diagnostics_by_code = {},

                -- inlay hints
                auto_inlay_hints = true,
                inlay_hints_highlight = "Comment",
                inlay_hints_priority = 200, -- priority of the hint extmarks
                inlay_hints_throttle = 150, -- throttle the inlay hint request
                inlay_hints_format = { -- format options for individual hint kind
                    Type = {},
                    Parameter = {},
                    Enum = {},
                    -- Example format customization for `Type` kind:
                    -- Type = {
                    --     highlight = "Comment",
                    --     text = function(text)
                    --         return "->" .. text:sub(2)
                    --     end,
                    -- },
                },

                -- update imports on file move
                update_imports_on_move = false,
                require_confirmation_on_move = false,
                watch_dir = nil,
            })

            -- required to fix code action ranges and filter diagnostics
            ts_utils.setup_client(client)

            -- no default maps, so you may want to define some here
            local opts = { silent = true }
            -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
        end
    end







    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

-- Remap Ctrl+i to signature help in insert mode
vim.api.nvim_buf_set_keymap(0, 'i', '<C-i>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('i', '<C-i>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- vim.api.nvim_create_autocmd("CursorHold", {
    --   buffer = bufnr,
    --   callback = function()
    --     local opts_ = {
    --       focusable = false,
    --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --       border = 'rounded',
    --       source = 'always',
    --       prefix = ' ',
    --       scope = 'cursor',
    --     }
    --     vim.diagnostic.open_float(nil, opts_)
    --   end
    -- })
end

protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

nvim_lsp.flow.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = capabilities
}

vim.cmd([[
autocmd FileType * inoremap <buffer><expr> <Tab> "\<Esc>"
]])


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
        html = {
            options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
            },
        },
    }
})

nvim_lsp.sourcekit.setup {
    on_attach = on_attach,
}

-- nvim_lsp.lua_ls.setup {
--   on_attach = function(client, bufnr)
--     on_attach(client, bufnr)
--     enable_format_on_save(client, bufnr)
--   end,
--   capabilities = capabilities,
--   settings = {
--     Lua = {
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = { 'vim' },
--       },
--
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false
--       },
--     },
--   },
-- }

local tw_highlight = require('tailwind-highlight')
nvim_lsp.tailwindcss.setup({
    on_attach = function(client, bufnr)
        tw_highlight.setup(client, bufnr, {
            single_column = false,
            mode = 'background',
            debounce = 200,
        })
    end,
    capabilities = capabilities
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
    })

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '●'
    },
    update_in_insert = true,
    float = {
        source = "always", -- Or "if_many"
    },
})
