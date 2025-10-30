return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { 'bash', 'c', 'dockerfile', 'json', 'lua', 'python', 'rust', 'terraform', 'typescript' },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = false },
        })
    end
}
