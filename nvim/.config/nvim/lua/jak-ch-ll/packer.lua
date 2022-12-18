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

        use 'tpope/vim-surround'
        use 'Raimondi/delimitMate'
        use 'lukas-reineke/indent-blankline.nvim'
        use 'stephenway/postcss.vim'
        use 'lewis6991/gitsigns.nvim'
        use 'mbbill/undotree'
        use 'tpope/vim-fugitive'
        use { "terrortylor/nvim-comment",
            requires = {
                use 'JoosepAlviste/nvim-ts-context-commentstring'
            }
        }
        use { 'ThePrimeagen/harpoon',
            requires = { 'nvim-lua/plenary.nvim' }
        }



        use { 'kyazdani42/nvim-tree.lua',
            requires = {
                'kyazdani42/nvim-web-devicons',
            },
        }

        use { 'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                { "nvim-telescope/telescope-file-browser.nvim" }
            },
        }

        use { 'jose-elias-alvarez/null-ls.nvim',
            requires = { "nvim-lua/plenary.nvim" },
        }

        use { 'nvim-treesitter/nvim-treesitter',
            run = function() require('nvim-treesitter.install').update({ with_sync = true })() end,
            requires = {
                'nvim-treesitter/playground'
            }
        }

        use { 'nvim-lualine/lualine.nvim',
            requires = {
                'kyazdani42/nvim-web-devicons',
                opt = true,
                config = function()
                    require('nvim-web-devicons').setup {
                        default = true,
                        icons_enabled = true
                    }
                end
            },
        }

        -- lsp
        -- use { 'neovim/nvim-lspconfig',
        --     requires = {
        --         'hrsh7th/nvim-cmp',
        --         'hrsh7th/cmp-nvim-lsp',
        --         'hrsh7th/cmp-buffer',
        --         'hrsh7th/cmp-path',
        --         'saadparwaiz1/cmp_luasnip',
        --         'L3MON4D3/LuaSnip',
        --         'simrat39/rust-tools.nvim',
        --         'williamboman/mason.nvim',
        --         'williamboman/mason-lspconfig.nvim',
        --         "b0o/schemastore.nvim",
        --         'jose-elias-alvarez/typescript.nvim',
        --         'lvimuser/lsp-inlayhints.nvim'
        --     }
        -- }
        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },

                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'rafamadriz/friendly-snippets' },

                -- Custom
                { 'lvimuser/lsp-inlayhints.nvim' },
                { "b0o/schemastore.nvim" },
            }
        }

        -- dap
        use { 'mfussenegger/nvim-dap',
            requires = {
                "mxsdev/nvim-dap-vscode-js",
                'theHamsta/nvim-dap-virtual-text',
                "rcarriga/nvim-dap-ui"
            }
        }

        -- colorschemes
        use 'folke/tokyonight.nvim'
        use 'ayu-theme/ayu-vim'
        use 'olimorris/onedarkpro.nvim'

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
