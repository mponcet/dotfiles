return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader><space>", ":Telescope buffers<cr>",    { desc = 'Telescope buffers' } },
        { "<leader>ff",      ":Telescope find_files<cr>", { desc = 'Telescope find files' } },
        { "<leader>gf",      ":Telescope git_files<cr>",  { desc = 'Telescop git files' } },
        { "<leader>fg",      ":Telescope live_grep<cr>",  { desc = 'Telescope live grep' } },
        { "<leader>km",      ":Telescope keymaps<cr>",    { desc = 'Telescope keymaps' } }
    }
}
