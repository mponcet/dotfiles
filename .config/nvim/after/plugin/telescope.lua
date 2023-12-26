require('telescope').setup({})

-- Enable telescope fzf native
require('telescope').load_extension('fzf')
-- Enable telescope file_browser plugin
require('telescope').load_extension('file_browser')

-- Add leader shortcuts
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.buffers)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<C-p>', builtin.git_files)
vim.keymap.set('n', '<leader>fg', builtin.grep_string)
vim.keymap.set('n', '<leader>fb', require('telescope').extensions.file_browser.file_browser, { noremap = true })
