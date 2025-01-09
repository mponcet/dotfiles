return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",                      -- Optional: For using slash commands and variables in the chat buffer
        "nvim-telescope/telescope.nvim",         -- Optional: For using slash commands
        { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    config = true,
    opts = {
        adapters = {
            openai = function()
                return require("codecompanion.adapters").extend("openai", {
                    env = {
                        api_key = "cmd:gopass show --password openai/OPENAI_API_KEY",
                    },
                })
            end,
            ollama = function()
                return require("codecompanion.adapters").extend("ollama", {
                    env = {
                        url = "http://localhost:11434",
                        -- api_key = "OLLAMA_API_KEY",
                    },
                    headers = {
                        ["Content-Type"] = "application/json",
                        -- ["Authorization"] = "Bearer ${api_key}",
                    },
                    parameters = {
                        sync = true,
                    },
                    schema = {
                        model = {
                            default = "deepseek-coder-v2:16b",
                        },
                    },
                })
            end,
        },
        strategies = {
            chat = {
                adapter = "ollama",
            },
            inline = {
                adapter = "ollama",
            },
            agent = {
                adapter = "ollama",
            },
        },
    },
    keys = {
        { "<F1>", ":CodeCompanionChat Toggle<cr>", },
    }
}
