return {
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/lua-language-server' },
    root_markers = { 'init.lua', '.luarc.json' },
    filetypes = { 'lua' },
    single_file_support = true,
    settings = {
        Lua = {
            runtime = {
                -- Neovim uses LuaJIT
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Recognize 'vim' as a global variable
                globals = { 'vim' },
            },
            workspace = {
                -- Include Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                -- Avoid prompts for third-party libraries
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        }
    }
}
