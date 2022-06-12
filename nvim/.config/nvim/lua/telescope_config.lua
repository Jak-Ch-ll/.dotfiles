require('telescope').setup{
    defaults = {
        mappings = {
            -- mappings for insert mode in telescope view
            i = {
                -- example
                -- ["<C-h>"] = "which_key",
                ["<C-h>"] = function() print("Hello, world!") end
            }
        }
    } 
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
