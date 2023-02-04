return {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    keys = {
        { '<leader>e', ':NvimTreeToggle<CR>', desc = 'Open [E]xplorer' },
        { '<leader>E', ':NvimTreeFindFile<CR>', desc = 'Open [E]xplorer with current file' },
    },
    opts = {
        hijack_cursor = true,


        -- files first
        sort_by = function(nodes)
            table.sort(nodes, function(a, b)
                -- sort directory after file
                if (a.type == 'directory' and b.type ~= 'directory') then
                    return false
                elseif (a.type ~= 'directory' and b.type == 'directory') then
                    return true
                end

                return a.name < b.name
            end)
        end,

        view = {
            number = true,
            relativenumber = true,
            width = {},
            mappings = {
                list = {
                    { key = 'l', action = 'preview' },
                    { key = 'h', action = 'close_node' }
                }
            },
            float = {
                enable = true,
                open_win_config = {
                    col = 100,
                    row = 0,
                    height = 100,
                    width = 40,
                    border = 'none',
                },
            }
        },

        renderer = {
            add_trailing = true,
            group_empty = true,
            indent_width = 4,
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└", edge = "│", item = "│", bottom = " ", none = " ",
                }
            },
            icons = {
                git_placement = 'after',
                modified_placement = 'before',
            },
            symlink_destination = false,
        },

        diagnostics = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = false,
        },

        git = {
            show_on_open_dirs = false,
        },

        modified = {
            enable = true,
            show_on_open_dirs = false,
        },

        live_filter = {
            prefix = '',
            always_show_folders = false,
        },

    },
    init = function()
        --vim.o.splitright = false
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- local augroup = vim.api.nvim_create_augroup("nvim-tree", { clear = true })
        --
        -- vim.api.nvim_create_autocmd(
        --     "BufDelete",
        --     {
        --         group = augroup,
        --         command = 'NvimTreeClose'
        --     }
        -- )
    end
}
