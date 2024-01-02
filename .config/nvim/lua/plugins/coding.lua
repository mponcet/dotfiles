return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    { "tpope/vim-fugitive" },
}
