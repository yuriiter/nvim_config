-- local status, saga = pcall(require, "lspsaga")
-- if (not status) then return end
--
-- saga.init_lsp_saga {
--   server_filetype_map = {
--     typescript = 'typescript'
--   }
-- }
--
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
-- vim.keymap.set('i', '<C-i>', '<Cmd>Lspsaga signature_help<CR>', opts)
-- vim.keymap.set('n', 'gs', '<Cmd>Lspsaga signature_help<CR>', opts)
-- vim.keymap.set('n', '<leader>lp', '<Cmd>Lspsaga preview_definition<CR>', opts)
-- vim.keymap.set('n', '<leader>lr', '<Cmd>Lspsaga rename<CR>', opts)
