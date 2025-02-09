return {
	{ import = 'plugins.lsp.languages' },
	{
		'neovim/nvim-lspconfig',
		event = 'VeryLazy',

		dependencies = {
			'williamboman/mason-lspconfig.nvim',

			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',

			'antosha417/nvim-lsp-file-operations',
		},

		init = function()
			local mason = require('mason-lspconfig')
			local lspconfig = require('lspconfig')
			local utils = require('utils')

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

			local function setup_with_options(options)
				return function(server_name)
					lspconfig[server_name].setup(
						utils.merge(shared_options, options)
					)
				end
			end

			-- Workaround for truncating long TypeScript inlay hints.
			-- Blatenly stolen from https://github.com/MariaSolOs/dotfiles/blob/02af18f67d60977023c35b8302c0cfd1abbe0f96/.config/nvim/lua/lsp.lua#L266m
			-- TODO: Remove this once there is a native solution (https://github.com/neovim/neovim/issues/27240)
			local methods = vim.lsp.protocol.Methods
			local inlay_hint_handler =
				vim.lsp.handlers[methods.textDocument_inlayHint]
			vim.lsp.handlers[methods.textDocument_inlayHint] = function(
				err,
				result,
				ctx,
				config
			)
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				if client and client.name == 'volar' then
					result = vim.iter(result)
						:map(function(hint)
							local label = hint.label ---@type string
							if label:len() >= 30 then
								label = label:sub(1, 29) .. '…'
							end
							hint.label = label
							return hint
						end)
						:totable()
				end

				inlay_hint_handler(err, result, ctx, config)
			end

			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/doc/md/lsp.md#you-might-not-need-lsp-zero
			mason.setup_handlers({
				setup_with_options(),

				['lua_ls'] = setup_with_options({
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
				}),

				-- ['rust_analyzer'] = function()
				--     require('rust-tools').setup({
				--         server = utils.merge(
				--             shared_options,
				--             {
				--                 settings = {
				--                     ["rust-analyzer"] = {
				--                         checkOnSave = {
				--                             command = "clippy"
				--                         }
				--                     }
				--                 }
				--             }
				--         )
				--     })
				-- end,

				-- ['tsserver'] = function()
				-- 	require('typescript').setup({
				-- 		server = utils.merge(
				-- 			shared_options,
				-- 			{
				-- 				settings = {
				-- 					typescript = {
				-- 						inlayHints = {
				-- 							includeInlayEnumMemberValueHints = true,
				-- 							includeInlayFunctionLikeReturnTypeHints = true,
				-- 							includeInlayFunctionParameterTypeHints = true,
				-- 							includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				-- 							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				-- 							includeInlayPropertyDeclarationTypeHints = true,
				-- 							includeInlayVariableTypeHints = true,
				-- 						},
				-- 					},
				-- 				}
				-- 			}
				-- 		)
				-- 	})
				-- end,

				['svelte'] = setup_with_options({
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
				}),

				['vtsls'] = setup_with_options({
					filetypes = { 'vue', 'typescript', 'javascript' },
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = {
									{
										name = '@vue/typescript-plugin',
										location = require('mason-registry')
											.get_package('vue-language-server')
											:get_install_path()
											.. '/node_modules/@vue/language-server',
										languages = { 'vue' },
										configNamespace = 'typescript',
										enableForWorkspaceTypeScriptVersions = true,
									},
								},
							},
							enableMoveToFileCodeAction = true,
							experimental = {

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
				}),

				['volar'] = setup_with_options({
					-- filetypes = { 'vue', 'typescript', 'javascript' },
					init_options = {
						vue = {
							hybridMode = true,
						},
					},
					settings = {
						vue = {
							-- server = {
							-- 	hybridMode = true,
							-- },
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
				}),

				['jsonls'] = function(server_name)
					setup_with_options({
						settings = {
							json = {
								schemas = require('schemastore').json.schemas(),
								validate = { enable = true },
							},
						},
					})(server_name)
				end,

				['emmet_language_server'] = setup_with_options({
					filetypes = {
						'html',
						'css',
						'scss',
					},
				}),
			})
		end,
	},
}

-- other language plugins
-- sigmaSd/deno-nvim

-- svelte = {
--     config = {
--         settings = {
--             svelte = {
--                 useNewTransformation = true
--             }
--         }
--     }
-- },
-- html = {
--     config = {
--         filetypes = { 'html', 'svelte' }
--     }
-- },
-- tailwindcss = {
--     config = {
--         root_dir = require('lspconfig').util.root_pattern('tailwind.config.js')
--     }
-- },
