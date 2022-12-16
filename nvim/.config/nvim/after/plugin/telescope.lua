local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
    defaults = {
        mappings = {
            -- mappings for insert mode in telescope view
            i = {
                -- example
                -- ["<C-h>"] = "which_key",
                ["<C-h>"] = function() print("Hello, world!") end
            }
        }
    },
    pickers = {
        buffers = {
            mappings = {
                n = {
                    ["x"] = actions.delete_buffer
                }
            }
        }
    }
}
telescope.load_extension('fzf')
telescope.load_extension('file_browser')

vim.keymap.set("n", "<C-p>", function()
    local tb = require('telescope.builtin')

    vim.fn.system('git rev-parse --is-inside-work-tree')

    print("Error: ", vim.v.shell_error)

    if vim.v.shell_error == 0 then
        tb.git_files({
            show_untracked = true
        })
    else
        tb.find_files()
    end
end)
vim.keymap.set('n', '<C-j>', ':cnext<CR>')
vim.keymap.set('n', '<C-k>', ':cprev<CR>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>')
