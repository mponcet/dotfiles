return {
    {
        'mrcjkb/rustaceanvim',
        version = '^6',
        lazy = false,
        init = function()
            vim.g.rustaceanvim = {
                server = {
                    default_settings = {
                        -- rust-analyzer language server configuration
                        ['rust-analyzer'] = {
                            cargo = {
                                allFeatures = true
                            },
                            check = {
                                command = "clippy"
                            },
                            inlayHints = {
                                lifetimeElisionHints = {
                                    enable = true,
                                    useParameterNames = true
                                },
                            }
                        },
                    },
                },
            }
        end
    }
}
