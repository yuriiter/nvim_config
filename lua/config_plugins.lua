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

if utils.isModuleAvailable("null-ls") then
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.completion.spell,
        },
    })
end


if utils.isModuleAvailable("tokyonight") then
vim.cmd[[colorscheme tokyonight-moon]]
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "moon", -- The theme is used when the background is set to light
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  on_colors = function(colors) end,

  on_highlights = function(highlights, colors) end,
})
end


if utils.isModuleAvailable("mini.comment") then
    require'mini.comment'.setup {
    }
end
