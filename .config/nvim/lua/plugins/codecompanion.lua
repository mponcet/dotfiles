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
        strategies = {
            chat = {
                adapter = "openai",
            },
            inline = {
                adapter = "openai",
            },
        },
        opts = {
            stream = true,
        },
        adapters = {
            openai = function()
                return require("codecompanion.adapters").extend("openai_compatible", {
                    name = "codestral",
                    env = {
                        url = "https://api.mistral.ai",
                        api_key = os.getenv("MISTRAL_API_KEY"),
                        chat_url = "/v1/chat/completions"
                    },
                    handlers = {
                        form_parameters = function(self, params, messages)
                            -- codestral doesn't support these in the body
                            params.stream_options = nil
                            params.options = nil

                            return params
                        end,
                    },
                    schema = {
                        model = {
                            default = "codestral-latest",
                        },
                        temperature = {
                            default = 0.2,
                            mapping = "parameters", -- not supported in default parameters.options
                        },
                    },
                })
            end,
        },
    },
    keys = {
        { "<F1>", ":CodeCompanionChat Toggle<cr>", },
    }
}
