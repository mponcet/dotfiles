return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>t]",
            function() require("trouble").next({ jump = true }) end,
            desc = "Next diagnostic (Trouble)",
        },
        {
            "<leader>t[",
            function() require("trouble").prev({ jump = true }) end,
            desc = "Prev diagnostic (Trouble)",
        },
    },
}
