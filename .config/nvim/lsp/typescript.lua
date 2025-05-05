return {
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/typescript-language-server' },
    root_markers = { 'tsconfig.json' },
    filetypes = { 'typescript' },
    single_file_support = true,
}
