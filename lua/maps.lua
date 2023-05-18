local utils = require("utils")

local map = vim.api.nvim_set_keymap

-- map the leader key
vim.g.mapleader = ' '  -- 'vim.g' sets global variables
vim.g.maplocalleader = ' '   -- 'vim.g' sets global variables
map("", "<Space>", "<Nop>", {}) -- disable space because leader

local options = { noremap = true }
map('n', '<Esc>', '<cmd>noh<cr>', options)

map('n', '<leader>w', '<cmd>w<cr>', options)
map('n', '<leader>q', '<cmd>q<cr>', options)
map('n', '<leader>bb', '<cmd>tabedit<cr>', options)
map('n', '<leader>c', '<cmd>bunload<cr>', options)
map('n', '<leader>t', '<cmd>term<cr>', options)
map('n', '<leader>z', '<cmd>luafile $MYVIMRC<cr>', options)

map('n', '<leader>x', '*``cgn', options)
map('n', '<leader>X', '#``cgN', options)
map('n', '<leader>z', '<cmd>luafile $MYVIMRC<cr>', options)
map('n', '<leader>as', [[:<C-u>let @/ = '\V' . escape('<C-r><C-w>', '/')<CR>:%s/<C-r>=escape('<C-r><C-w>', '/')<CR>/]], { noremap = true,  })
map('n', '<leader>ai', ':TypescriptAddMissingImports<CR>', options)
map('n', '<leader>af', ':TypescriptRenameFile<CR>', options)

map('x', 'p', "]pgvy", options)
map('n', 'p', "]p", options)
map('n', 'P', "]P", options)



vim.cmd([[
" Open NERDTree in the directory of the current file (or /home if no file is open)
nmap <silent> <leader>o :silent! call NERDTreeFocusInCurDir()<cr>
function! NERDTreeFocusInCurDir()
  " If NERDTree is open in the current buffer

  if (stridx(bufname('%'), 'NERD_tree_') == -1 && bufname() != "" && &buftype == "" && &filetype != "")
    exe ":NERDTreeFind"
endif
endfunction
nmap <silent> <leader>e :call NERDTreeToggleInCurDir()<cr>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction
]])

map('n', '<S-h>', 'gT', options)
map('n', '<S-l>', 'gt', options)
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("v", "<", "<gv", options)
map("v", ">", ">gv", options)

map("t", "<esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<c-\\><c-n><c-h>", { desc = "Enter Normal Mode" })
map("t", "<C-j>", "<c-\\><c-n><c-j>", { desc = "Enter Normal Mode" })
map("t", "<C-k>", "<c-\\><c-n><c-k>", { desc = "Enter Normal Mode" })
map("t", "<C-l>", "<c-\\><c-n><c-l>", { desc = "Enter Normal Mode" })
map('i', '<Tab>', '<Esc>', { noremap = false})
map('i', '<C-i>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })


map('i', '<C-h>', '<Left>', options)
map('i', '<C-j>', '<Down>', options)
map('i', '<C-k>', '<Up>', options)
map('i', '<C-l>', '<Right>', options)

map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })





if utils.isModuleAvailable("telescope.builtin") then
	-- Telescope
	local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})
	vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fW', builtin.grep_string, {})
	vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
	vim.keymap.set('n', '<leader>fm', builtin.man_pages, {})
    vim.keymap.set('n', '<leader>fs', '<cmd>Telescope cheat fd<CR>', {})

	-- Telescope LSP
	vim.keymap.set('n', '<leader>lR', builtin.lsp_references, {})
	vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, {})
	vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
	vim.keymap.set('n', 'gr', builtin.lsp_references, {})
	vim.keymap.set('n', '<leader>lD', builtin.diagnostics, {})
	vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, {})

	-- vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})

	-- Telescope git
	vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
	vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})


	-- vim.keymap.set('i', '<C-j>', actions.move_selection_next(1), {})
	-- vim.keymap.set('i', '<C-k>', actions.move_selection_prev(-1), {})

    -- Telescop cycle through history
	-- vim.keymap.set('i', '<C-n>', actions.cycle_history_next, {})
	-- vim.keymap.set('i', '<C-p>', actions.cycle_history_prev, {})
end

if utils.isModuleAvailable("packer") then
	vim.keymap.set('n', '<leader>ps', ":PackerSync<CR>", {})
	vim.keymap.set('n', '<leader>pc', ":PackerClean<CR>", {})
	vim.keymap.set('n', '<leader>pi', ":PackerInstall<CR>", {})
	vim.keymap.set('n', '<leader>pu', ":PackerUpdate<CR>", {})
end
if utils.isModuleAvailable("mason") then
	vim.keymap.set('n', '<leader>pm', ":Mason<CR>", {})
end
