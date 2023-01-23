local function custom_find_files()
    vim.fn.system('git rev-parse --is-inside-work-tree')

    print("Error: ", vim.v.shell_error)

    if vim.v.shell_error == 0 then
        require('telescope.builtin').git_files({
            show_untracked = true
        })
    else
        require('telescope.builtin').find_files()
    end
end


return { 
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { "nvim-telescope/telescope-file-browser.nvim" }
    },
    keys = {
        { '<C-p>', custom_find_files, desc = '[C-p] Project files' },
        {
            '<leader>/', 
            function()
                require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end,
            desc = '[/] Fuzzily search in current buffer]'
        },
        { '<leader>b', function() require('telescope.builtin').buffers() end, desc = '[B]uffers' },
        
        { '<leader>sh', function() require('telescope.builtin').help_tags() end, desc = '[S]earch [H]elp' },
        { '<leader>sw', function() require('telescope.builtin').grep_string() end, desc = '[S]earch current [W]ord' },
        { '<leader>sg', function() require('telescope.builtin').live_grep() end, desc = '[S]earch by [G]rep' },
        { '<leader>sd', function() require('telescope.builtin').diagnostics() end, desc = '[S]earch [D]iagnostics' },
        { '<leader>sk', function() require('telescope.builtin').keymaps() end, desc = '[S]earch [K]eymaps' },
        
        -- diagnostics
        { "<leader>dn", vim.diagnostic.goto_next, desc = '[D]iagnostics [N]ext' },
        { "<leader>dp", vim.diagnostic.goto_prev, desc = '[D]iagnostics [P]revious' },
        { "<leader>dl", function() require('telescope.builtin').diagnostics() end, desc = '[D]iagnostics [L]ist' },
        { '<leader>dh', vim.diagnostic.open_float, desc = '[D]iagnostics [H]over' },
    },
    config = function()
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
                },
                vimgrep_arguments = {
                    -- default
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",

                    -- custom changes
                    "--hidden"
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
        telescope.load_extension('harpoon')

        -- local tb = require('telescope.builtin')
        --
        -- local nmap = function(keys, func, desc)
        --     if desc then
        --         desc = 'Telescope: ' .. desc
        --     end
        --
        --     vim.keymap.set('n', keys, func, { desc = desc })
        -- end
        --
        -- local function custom_find_files()
        --     vim.fn.system('git rev-parse --is-inside-work-tree')
        --
        --     print("Error: ", vim.v.shell_error)
        --
        --     if vim.v.shell_error == 0 then
        --         tb.git_files({
        --             show_untracked = true
        --         })
        --     else
        --         tb.find_files()
        --     end
        -- end
        --
        -- nmap('<C-p>', custom_find_files, '[C-p] Project files')
        -- nmap('<leader>/', function()
        --     require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        --         winblend = 10,
        --         previewer = false,
        --     })
        -- end, '[/] Fuzzily search in current buffer]')
        -- nmap('<leader>b', tb.buffers, '[B]uffers')
        --
        -- nmap('<leader>sh', tb.help_tags, '[S]earch [H]elp')
        -- nmap('<leader>sw', tb.grep_string, '[S]earch current [W]ord')
        -- nmap('<leader>sg', tb.live_grep, '[S]earch by [G]rep')
        -- nmap('<leader>sd', tb.diagnostics, '[S]earch [D]iagnostics')
        -- nmap('<leader>sk', tb.keymaps, '[S]earch [K]eymaps')
        --
        -- -- diagnostics
        -- nmap("<leader>dn", vim.diagnostic.goto_next, '[D]iagnostics [N]ext')
        -- nmap("<leader>dp", vim.diagnostic.goto_prev, '[D]iagnostics [P]revious')
        -- nmap("<leader>dl", tb.diagnostics, '[D]iagnostics [L]ist')
        -- nmap('<leader>dh', vim.diagnostic.open_float, '[D]iagnostics [H]over')
    end
}
