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
