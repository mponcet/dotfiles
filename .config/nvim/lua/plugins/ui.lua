return {
    {
        "chriskempson/base16-vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme base16-gruvbox-dark-hard]]
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'gruvbox_dark',
            },
            sections = {
                lualine_c = {
                    { 'filename', path = 1 }
                },
            },
        }
    },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
    }
}
