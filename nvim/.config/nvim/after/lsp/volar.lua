---@type vim.lsp.Config
return {
	cmd = { 'bunx', '--bun', 'vue-language-server', '--stdio' },
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
