local on_attach = require('utils/lsp/on-attach')

vim.lsp.config('*', {
	on_attach = on_attach,
	capabilities = require('lsp-file-operations').default_capabilities(),
})

vim.filetype.add({
	filename = { ['.gitlab-ci.yml'] = 'yaml.gitlab' },
})

vim.lsp.enable({
	'cssls',
	'emmet_language_server',
	'eslint',
	'docker_compose_language_service',
	'dockerls',
	'gitlab_ci_ls',
	'html',
	'jsonls',
	'yamlls',
	'lua_ls',
	'svelte',
	'volar',
	'vtsls',
})
