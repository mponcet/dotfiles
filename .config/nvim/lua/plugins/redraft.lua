return {
    "jim-at-jibba/nvim-redraft",
    dependencies = {
        { "folke/snacks.nvim", opts = { input = {} } },
    },
    event = "VeryLazy",
    build = "cd ts && npm install && npm run build",
    opts = {
        llm = {
            models = {
                { provider = "openrouter", model = "mistralai/devstral-2512", label = "OpenRouter Devstral" },
            }
        }
    }
}
