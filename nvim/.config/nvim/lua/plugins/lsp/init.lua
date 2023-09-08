return {
    { import = 'plugins.lsp.languages' },
    {
        'neovim/nvim-lspconfig',
        event = 'VeryLazy',

        dependencies = {
            'williamboman/mason-lspconfig.nvim',

            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
        },

        config = function()
            local mason = require('mason-lspconfig')
            local lspconfig = require('lspconfig')
            local utils = require('utils')

            local on_attach = require('utils/lsp/on-attach')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local shared_options = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            local function setup_with_options(options)
                return function(server_name)
                    lspconfig[server_name].setup(
                        utils.merge(
                            shared_options,
                            options
                        )
                    )
                end
            end

            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/doc/md/lsp.md#you-might-not-need-lsp-zero
            mason.setup_handlers({
                setup_with_options(),

                ["lua_ls"] = setup_with_options({
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT',
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { 'vim' },
                            },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = {
                                enable = false,
                            },
                            hint = {
                                enable = true
                            }
                        }
                    }
                }),

                ['rust_analyzer'] = function()
                    require('rust-tools').setup({
                        server = utils.merge(
                            shared_options,
                            {
                                settings = {
                                    ["rust-analyzer"] = {
                                        checkOnSave = {
                                            command = "clippy"
                                        }
                                    }
                                }
                            }
                        )
                    })
                end,

                ['tsserver'] = function()
                    require('typescript').setup({
                        server = utils.merge(
                            shared_options,
                            {
                                settings = {
                                    typescript = {
                                        inlayHints = {
                                            includeInlayEnumMemberValueHints = true,
                                            includeInlayFunctionLikeReturnTypeHints = true,
                                            includeInlayFunctionParameterTypeHints = true,
                                            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                            includeInlayPropertyDeclarationTypeHints = true,
                                            includeInlayVariableTypeHints = true,
                                        },
                                    },
                                }
                            }
                        )
                    })
                end,

                ['jsonls'] = function(server_name)
                    setup_with_options({
                        settings = {
                            json = {
                                schemas = require('schemastore').json.schemas(),
                                validate = { enable = true },
                            }
                        }
                    })(server_name)


                ['efm'] = function(server_name)
                    local prettierd = {
                        formatCommand =
                        'prettierd ${INPUT} ${--range-start=charStart} ${--range-end=charEnd} ${--tab-width=tabSize}',
                        formatStdin = true,
                        -- rootMarkers = {
                        --     '.prettierrc',
                        --     '.prettierrc.json',
                        --     '.prettierrc.js',
                        --     '.prettierrc.yml',
                        --     '.prettierrc.yaml',
                        --     '.prettierrc.json5',
                        --     '.prettierrc.mjs',
                        --     '.prettierrc.cjs',
                        --     '.prettierrc.toml',
                        -- }
                    }

                    lspconfig.efm.setup({
                        init_options = { documentFormatting = true },
                        settings = {
                            -- rootMarkers = { ".git/" },
                            languages = {
                                javascript = { prettierd },
                                typescript = { prettierd },
                                yaml = { prettierd },
                                json = { prettierd },
                                html = { prettierd },
                                css = { prettierd },
                                scss = { prettierd },
                                xml = { prettierd },
                            }
                        },
                        filetypes = { 'javascript', 'typescript', 'yaml', 'json', 'html', 'css', 'scss', 'xml' }
                    })
                end

            })
        end
    }
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
