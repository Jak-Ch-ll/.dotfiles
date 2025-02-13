return {
	{ import = 'plugins.lsp.languages' },
	{
		'neovim/nvim-lspconfig',
		event = 'VeryLazy',

		dependencies = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',

			'antosha417/nvim-lsp-file-operations',
		},

		init = function()
			local lspconfig = require('lspconfig')
			local on_attach = require('utils/lsp/on-attach')

			local capabilities = vim.tbl_deep_extend(
				'force',
				require('cmp_nvim_lsp').default_capabilities(),
				require('lsp-file-operations').default_capabilities()
			)
			local shared_options = {
				on_attach = on_attach,
				capabilities = capabilities,
			}

			local servers = {
				cssls = {},

				emmet_language_server = {
					filetypes = {
						'html',
						'css',
						'scss',
					},
				},

				eslint = {},
				docker_compose_language_service = {},
				dockerls = {},
				gitlab_ci_ls = {},
				html = {},

				jsonls = {
					settings = {
						json = {
							schemas = require('schemastore').json.schemas(),
							validate = { enable = true },
						},
					},
				},

				yamlls = {
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
				},

				lua_ls = {
					on_init = function(client)
						local path = client.workspace_folders[1].name
						if
							vim.loop.fs_stat(path .. '/.luarc.json')
							or vim.loop.fs_stat(path .. '/.luarc.jsonc')
						then
							return
						end

						client.config.settings.Lua = vim.tbl_deep_extend(
							'force',
							client.config.settings.Lua,
							{
								runtime = {
									version = 'LuaJIT',
								},
								-- Make the server aware of Neovim runtime files
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
									},
								},
								diagnostics = {
									disable = { 'undefined-field' },
								},
							}
						)
					end,
					settings = {
						Lua = {
							-- Do not send telemetry data containing a randomized but unique identifier
							telemetry = {
								enable = false,
							},
							hint = {
								enable = true,
								arrayIndex = 'Disable',
							},
						},
					},
				},

				svelte = {
					settings = {
						typescript = {
							inlayHints = {
								parameterNames = {
									enabled = true,
								},
								parameterTypes = {
									enabled = true,
								},
								variableTypes = {
									enabled = true,
								},
								propertyDeclarationTypes = {
									enabled = true,
								},
								functionLikeReturnTypes = {
									-- for some reason inlay hints break for
									-- svelte lsp when this is enabled
									-- @todo need to investigate further
									enabled = false,
								},
								enumMemberValues = {
									enabled = true,
								},
							},
						},
					},
				},

				volar = {
					cmd = { 'bunx', '--bun', 'vue-language-server', '--stdio' },
					init_options = {
						vue = {
							hybridMode = true,
						},
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
				},

				vtsls = {
					filetypes = { 'vue', 'typescript', 'javascript' },
					cmd = { 'bunx', '--bun', 'vtsls', '--stdio' },
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = {
									{
										name = '@vue/typescript-plugin',
										location = vim.fs.root(
											vim.fn.exepath(
												'vue-language-server'
											),
											'bin'
										)
											.. '/lib/node_modules/@vue/language-server',
										languages = { 'vue' },
										configNamespace = 'typescript',
										enableForWorkspaceTypeScriptVersions = true,
									},
								},
							},
							enableMoveToFileCodeAction = true,
							experimental = {
								-- Keep an eye on: https://github.com/neovim/neovim/issues/27240)
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
						javascript = {
							-- inlayHints = {
							-- 	parameterNames = { enabled = 'literals' },
							-- 	parameterTypes = { enabled = true },
							-- 	variableTypes = { enabled = true },
							-- 	propertyDeclarationTypes = { enabled = true },
							-- 	functionLikeReturnTypes = { enabled = true },
							-- 	enumMemberValues = { enabled = true },
							-- },
						},
					},
				},
			}

			local function setup_servers()
				for server_name, options in pairs(servers) do
					local server_options = type(options) == 'function'
							and options(server_name)
						or options
					lspconfig[server_name].setup(
						vim.tbl_deep_extend(
							'force',
							shared_options,
							server_options
						)
					)
				end
			end
			setup_servers()
		end,
	},
}
