---@type vim.lsp.Config
return {
	cmd = { 'bunx', '--bun', 'vtsls', '--stdio' },
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
		'vue',
	},
	root_markers = { 'tsconfig.json' },

	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = '@vue/typescript-plugin',
						location = vim.fs.root(
							vim.fn.exepath('vue-language-server'),
							'bin'
						) .. '/lib/language-tools/packages/language-server',
						languages = { 'vue' },
						configNamespace = 'typescript',
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
			enableMoveToFileCodeAction = true,
			experimental = {
				-- Keep an eye on: https://github.com/neovim/neovim/issues/27240
				maxInlayHintLength = 30,
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			updateImportsOnFileMove = {
				enabled = 'always',
			},
			inlayHints = {
				parameterNames = { enabled = 'literals' },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
			preferences = {
				preferTypeOnlyAutoImports = true,
				useAliasesForRenames = false,
			},
			tsserver = {
				experimental = {
					-- enableProjectDiagnostics = true,
				},
			},
		},

		-- Inlay hints in Vue files temporary disabled because of this
		-- issue: https://github.com/neovim/neovim/issues/32248
		-- javascript = {
		-- 	inlayHints = {
		-- 		parameterNames = { enabled = 'literals' },
		-- 		parameterTypes = { enabled = true },
		-- 		variableTypes = { enabled = true },
		-- 		propertyDeclarationTypes = { enabled = true },
		-- 		functionLikeReturnTypes = { enabled = true },
		-- 		enumMemberValues = { enabled = true },
		-- 	},
		-- },
	},
}
