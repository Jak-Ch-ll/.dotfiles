return {
	'pmizio/typescript-tools.nvim',
	dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
	enabled = false,
	ft = { 'typescript', 'typescriptreact', 'vue' },
	config = function()
		local on_attach = require('utils/lsp/on-attach')
		local mason_registry = require('mason-registry')
		local vue_language_server_path = mason_registry
			.get_package('vue-language-server')
			:get_install_path() .. '/node_modules/@vue/language-server'

		require('typescript-tools').setup({
			on_attach = on_attach,
			filetypes = { 'typescript', 'typescriptreact', 'vue' },
			settings = {
				tsserver_plugins = {
					{
						name = '@vue/typescript-plugin',
						location = vue_language_server_path,
						languages = { 'vue' },
					},
				},
				tsserver_file_preferences = {
					includeInlayParameterNameHints = 'all',
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		})
	end,
}
