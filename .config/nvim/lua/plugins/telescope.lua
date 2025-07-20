return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader><space>", ":Telescope buffers<cr>" },
        { "<leader>ff",      ":Telescope find_files<cr>" },
        { "<C-p>",           ":Telescope git_files<cr>" },
        { "<leader>fg",      ":Telescope grep_string<cr>" },
        { "<leader>km",      ":Telescope keymaps<cr>" }
    }
}
