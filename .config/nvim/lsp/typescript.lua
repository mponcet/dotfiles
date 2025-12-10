return {
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/vtsls', '--stdio' },
    root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    single_file_support = true,
}
