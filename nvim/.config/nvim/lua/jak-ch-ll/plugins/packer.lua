-- autoinstall packer from Github
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end 

return require('packer').startup({
    function(use)
        -- packer manages itself
        use 'wbthomason/packer.nvim'

        use(require('jak-ch-ll/plugins/colorscheme'))
        use(require('jak-ch-ll/plugins/lualine'))
        use(require('jak-ch-ll/plugins/telescope'))

        use 'tpope/vim-surround'
        use 'Raimondi/delimitMate'
        use {
            'Yggdroot/indentLine',
            config = function()
                vim.g.indentLine_char = '│'
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
                'simrat39/rust-tools.nvim'
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
