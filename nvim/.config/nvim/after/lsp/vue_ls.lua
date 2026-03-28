---@type vim.lsp.Config
return {
	cmd = {
		'/home/j/projects/vue-language-tools/packages/language-server/bin/vue-language-server.js',
		'--stdio',
	},
	settings = {
		vue = {
			complete = {
				casing = {
					props = 'autoCamel',
				},
				autoInsert = {
					dotValue = true,
				},
			},
			hover = {
				rich = 'jsdoc',
			},
			inlayHints = {
				destructuredProps = true,
				missingProps = true,

				optionsWrapper = false,
				inlineHandlerLeading = false,
				vBindShorthand = false,
				includeInlayVariableTypeHints = false,
			},
		},
	},
}
