return {
    "pablopunk/pi.nvim",
    keys = {
        { "<leader>ai", "<cmd>PiAsk<CR>", mode = "n", desc = "Ask pi" },
        { "<leader>ai", "<cmd>PiAskSelection<CR>", mode = "v", desc = "Ask pi (selection)" },
    },
    opts = {
        tools = { "read", "edit", "write", "grep" },
    },
    init = function()
        -- force pi.nvim to use the notify backend instead of the builtin floating window
        _G.__pi_force_notify_backend = true
    end
}
