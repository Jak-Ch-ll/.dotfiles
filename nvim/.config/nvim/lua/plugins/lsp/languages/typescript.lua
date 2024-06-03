return {
	-- {
	-- 	'pmizio/typescript-tools.nvim',
	-- 	dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
	-- 	enabled = true,
	-- 	ft = { 'typescript', 'typescriptreact', 'vue' },
	-- 	config = function()
	-- 		local on_attach = require('utils/lsp/on-attach')
	-- 		local mason_registry = require('mason-registry')
	-- 		local vue_language_server_path = mason_registry
	-- 			.get_package('vue-language-server')
	-- 			:get_install_path() .. '/node_modules/@vue/language-server'
	--
	-- 		require('typescript-tools').setup({
	-- 			on_attach = on_attach,
	-- 			filetypes = { 'typescript', 'typescriptreact', 'vue' },
	-- 			settings = {
	-- 				tsserver_plugins = {
	-- 					'@vue/typescript-plugin',
	-- 					-- {
	-- 					-- 	name = '@vue/typescript-plugin',
	-- 					-- 	location = vue_language_server_path,
	-- 					-- 	languages = { 'vue' },
	-- 					-- },
	-- 				},
	-- 				-- tsserver_file_preferences = {
	-- 				-- 	includeInlayParameterNameHints = 'all',
	-- 				-- 	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	-- 				-- 	includeInlayFunctionParameterTypeHints = true,
	-- 				-- 	includeInlayVariableTypeHints = true,
	-- 				-- 	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
	-- 				-- 	includeInlayPropertyDeclarationTypeHints = true,
	-- 				-- 	includeInlayFunctionLikeReturnTypeHints = true,
	-- 				-- 	includeInlayEnumMemberValueHints = true,
	-- 				-- },
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		'yioneko/nvim-vtsls',
		ft = { 'typescript', 'typescriptreact', 'vue' },
	},
	{
		'catgoose/vue-goto-definition.nvim',
		ft = { 'typescript', 'vue' },
		opts = {
			filters = {
				auto_imports = true, -- resolve definitions in auto-imports.d.ts
				auto_components = true, -- resolve definitions in components.d.ts
				import_same_file = true, -- filter location list entries referencing an
				-- import in the current file.  See below for details
				declaration = true, -- filter declaration files unless the only location list
				-- item is a declaration file
				duplicate_filename = true, -- dedupe duplicate filenames
			},
			filetypes = { 'vue', 'typescript' }, -- enabled for filetypes
			detection = { -- framework detection.  Detection functions can be overridden here
				nuxt = function() -- look for .nuxt directory
					return vim.fn.glob('.nuxt/') ~= ''
				end,
				vue3 = function() -- look for vite.config.ts or App.vue
					return vim.fn.filereadable('vite.config.ts') == 1
						or vim.fn.filereadable('src/App.vue') == 1
				end,
				priority = { 'nuxt', 'vue3' }, -- order in which to detect framework
			},
			lsp = {
				override_definition = true, -- override vim.lsp.buf.definition
			},
			debounce = 200,
		},
	},
}
