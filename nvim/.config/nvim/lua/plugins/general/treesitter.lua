return {
    'nvim-treesitter/nvim-treesitter',
    name = 'Treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
    dependencies = {
        {

            'nvim-treesitter/playground',
            cmd = { 'TSPlaygroundToggle', 'TSNodeUnderCursor', 'TSHighlightCapturesUnderCursor' },
        },
        {
            'nvim-treesitter/nvim-treesitter-context',
            event = 'VeryLazy'
        }
    },
    init = function()
        require 'nvim-treesitter.configs'.setup {
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true
            },

            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            }
        }

        -- io stuff
        local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
        parser_config.io = {
            install_info = {
                url = "~/repos/tree-sitter-io",
                files = { "src/parser.c" }
            }
        }
        parser_config.prolog = {
            install_info = {
                url = 'https://github.com/Rukiza/tree-sitter-prolog',
                files = { "src/parser.c" },
            },
            filetype = "pl"
        }

        vim.filetype.add({
            extension = {
                io = 'io',
                pl = 'prolog',
            }
        })
    end,
}
