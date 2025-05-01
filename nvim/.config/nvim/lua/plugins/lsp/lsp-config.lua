return {
	{ import = 'plugins.lsp.languages' },
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		dependencies = {
			'antosha417/nvim-lsp-file-operations',
		},
	},
}
