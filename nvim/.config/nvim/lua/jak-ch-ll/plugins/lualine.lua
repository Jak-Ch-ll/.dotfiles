return {
    'nvim-lualine/lualine.nvim',
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
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = false
            },
            sections = {
                lualine_a = {},
                lualine_x = {'filetype', 'progress', 'location'},
                lualine_y = {},
                lualine_z = {},
            }
        })
    end
}
