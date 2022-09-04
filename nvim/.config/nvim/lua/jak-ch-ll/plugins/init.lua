-- autoinstall packer from Github
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

return require('packer').startup({
    function(use)
        -- packer manages itself
        use 'wbthomason/packer.nvim'

        use(require('jak-ch-ll/plugins/colorscheme'))
        use(require('jak-ch-ll/plugins/lualine'))
        use(require('jak-ch-ll/plugins/telescope'))
        use(require('jak-ch-ll/plugins/null-ls'))
        use(require('jak-ch-ll/plugins/treesitter'))
        use(require('jak-ch-ll/plugins/nvim-tree'))

        use 'tpope/vim-surround'
        use 'Raimondi/delimitMate'
        use 'lukas-reineke/indent-blankline.nvim'
        use 'stephenway/postcss.vim'
        use { 'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup({
                    signs = {
                        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
                        change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr",
                            linehl = "GitSignsChangeLn" },
                        delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr",
                            linehl = "GitSignsDeleteLn" },
                        topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr",
                            linehl = "GitSignsDeleteLn" },
                        changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr",
                            linehl = "GitSignsChangeLn" },
                    },
                })
            end
        }

        -- lsp
        use {
            'neovim/nvim-lspconfig',
            requires = {
                'hrsh7th/nvim-cmp',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'saadparwaiz1/cmp_luasnip',
                'L3MON4D3/LuaSnip',
                'simrat39/rust-tools.nvim',
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                "b0o/schemastore.nvim",
                'jose-elias-alvarez/typescript.nvim'
            }
        }

        -- sync packer after install
        if packer_bootstrap then
            require('packer').sync()
        end
    end,

    -- packer floating window
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})
