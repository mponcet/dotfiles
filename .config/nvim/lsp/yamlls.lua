return {
    cmd = { vim.fn.stdpath('data') .. '/mason/bin/yaml-language-server', '--stdio' },
    filetypes = { 'yaml' },
    settings = {
        yaml = {
            schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
            kubernetesCRDStore = {
                enable = true,
            },
	    schemas = {
		kubernetes = {
	            'flux*/**/*.yaml'
		},
	    },
        },
    },
}
