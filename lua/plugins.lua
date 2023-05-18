local utils = require("utils")

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
}
)

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'williamboman/mason-lspconfig.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
        -- setup
    }
    use {'nvim-telescope/telescope-ui-select.nvim' }
    use {
        'nvim-telescope/telescope-smart-history.nvim',
        requires = { {'kkharji/sqlite.lua'} }
        -- setup
    }
    use {
        "yorik1984/telescope-cheat.nvim",
        requires = {
            "kkharji/sqlite.lua",
            "nvim-telescope/telescope.nvim"
        }
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use 'echasnovski/mini.pairs'
    use 'echasnovski/mini.comment'
    use "tpope/vim-surround"
    use 'preservim/nerdtree'

    use 'jose-elias-alvarez/typescript.nvim'

    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
    use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"
    use {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
    }

    use 'lukas-reineke/indent-blankline.nvim'


    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'

    use 'lewis6991/gitsigns.nvim'
    -- LSP
    use 'onsails/lspkind-nvim' -- vscode-like pictograms
    use 'neovim/nvim-lspconfig' -- LSP
    use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
    use 'princejoogie/tailwind-highlight.nvim'
    use 'glepnir/lspsaga.nvim' -- LSP UIs
    use 'onsails/lspkind.nvim'
    use 'APZelos/blamer.nvim'
    use 'norcalli/nvim-colorizer.lua'


    use 'mfussenegger/nvim-dap'
    use 'ggandor/leap.nvim'

    use 'chemzqm/vim-jsx-improve'
    use 'peitalin/vim-jsx-typescript'
    use "MaxMEllon/vim-jsx-pretty"
    use 'jparise/vim-graphql'


    use { "catppuccin/nvim", as = "catppuccin" }

    use 'ray-x/lsp_signature.nvim'


    if packer_bootstrap then
        require('packer').sync()
    end



end)
