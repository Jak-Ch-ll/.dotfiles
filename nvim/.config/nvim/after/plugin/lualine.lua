local custom_filename = require('lualine.components.filename'):extend()

local function buf_number()
    local current_buf = vim.api.nvim_get_current_buf()
    return current_buf .. ': '
end

local function current_folder()
    local path = vim.api.nvim_buf_get_name(0)

    local filename_matcher = '/[^/]+$'

    path = path:gsub(filename_matcher, '')

    if (path == nil or path == '') then return '' end

    local foldername = string.match(path, '[^/]+$')

    return '(' .. foldername .. ') '


end

function custom_filename:update_status()
    local data = custom_filename.super.update_status(self)
    --
    local foldername = current_folder()

    return buf_number() .. foldername .. data
end

require('lualine').setup({
    options = {
        icons_enabled = true,
        ignore_focus = {
            'NvimTree',
            'help'
        },
    },
    sections = {
        lualine_a = {},
        lualine_b = {
            'branch',
            'diagnostics',
        },
        lualine_c = {
            {
                custom_filename,
                newfile_statue = true,
                symbols = {
                    modified = '•',
                }
            },
        },
        lualine_x = { 'filetype', 'progress', 'location' },
        lualine_y = {},
        lualine_z = {},
    }
})
