-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

require('lazy').setup('plugins')

-- Enable relative line number
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

-- Make line numbers default
vim.wo.number = true

-- Set highlight on search
vim.o.hlsearch = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Set colorscheme
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd [[colorscheme base16-gruvbox-dark-hard]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Set statusba
require('lualine').setup({
  options = {
    theme = 'gruvbox_dark',
  },
  sections = {
    lualine_c = {
      { 'filename', path = 1 }
    },
  },
})

-- Enable Comment.nvim
require('Comment').setup()

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Switch beetween buffers with arrow keys
vim.keymap.set('n', '<left>', ':bp<CR>')
vim.keymap.set('n', '<right>', ':bn<CR>')

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Telescope
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

-- Treesitter configuration
require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = { 'bash', 'c', 'dockerfile', 'json', 'lua', 'python', 'rust', 'terraform', 'typescript', 'vimdoc' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = false, -- buggy :'(
  },
})

-- lsp
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['tsserver'] = { 'javascript', 'typescript' },
    ['rust_analyzer'] = { 'rust' },
  }
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

require('lspconfig').rust_analyzer.setup({})

local rust_analyzer = function()
  local rust_tools = require('rust-tools')

  rust_tools.setup({
    server = {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = {
            -- default: `cargo check`
            command = 'clippy'
          },
        },
      },
    }
  })
end

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer' },
  handlers = {
    lsp_zero.default_setup,
    rust_analyzer = rust_analyzer,
  },
})

local cmp = require('cmp')
cmp.setup({})

require('nvim-autopairs').setup({})

-- gp.nvim
require('gp').setup({})

-- vim: ts=2 sts=2 sw=2 et
