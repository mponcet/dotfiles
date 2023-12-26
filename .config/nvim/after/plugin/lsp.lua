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
