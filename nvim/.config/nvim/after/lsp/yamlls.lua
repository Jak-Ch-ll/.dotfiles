---@type vim.lsp.Config
return {
	settings = {
		yaml = {
			-- https://github.com/b0o/SchemaStore.nvim?tab=readme-ov-file#usage
			schemaStore = {
				enable = false,
				url = '',
			},
			schemas = require('schemastore').yaml.schemas(),
		},
	},
}
