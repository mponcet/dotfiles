return {
    {
        "chriskempson/base16-vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[colorscheme base16-gruvbox-dark-hard]]
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'gruvbox_dark',
            },
            sections = {
                lualine_c = {
                    { 'filename', path = 1 }
                },
            },
        },
        config = function(_, opts)
            require('lualine').setup(opts)

            -- Hide lualine when Avante is active
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
                callback = function()
                    if vim.bo.filetype == 'Avante' then
                        require('lualine').hide()
                    end
                end,
            })
        end,
    },
}
