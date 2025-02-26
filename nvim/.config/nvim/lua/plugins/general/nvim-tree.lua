local function on_attach(bufnr)
	local api = require('nvim-tree.api')

	local function opts(desc)
		return {
			desc = 'nvim-tree: ' .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	api.config.mappings.default_on_attach(bufnr)

	-- Custom keymaps
	for _, key in ipairs({ 'l', '<Right>' }) do
		vim.keymap.set('n', key, api.node.open.preview, opts('Open Preview'))
	end
	for _, key in ipairs({ 'h', '<Left>' }) do
		vim.keymap.set(
			'n',
			key,
			api.node.navigate.parent_close,
			opts('Close Directory')
		)
	end
end

return {
	{
		'nvim-tree/nvim-tree.lua',

		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},

		keys = {
			{
				'<leader>e',
				':NvimTreeToggle<CR>',
				desc = 'Open [E]xplorer',
			},
			{
				'<leader>E',
				':NvimTreeFindFileToggle<CR>',
				desc = 'Open [E]xplorer with current file',
			},
		},

		opts = {
			on_attach = on_attach,

			hijack_cursor = true,

			sort_by = function(nodes)
				-- files first
				table.sort(nodes, function(a, b)
					-- sort directory after file
					if a.type == 'directory' and b.type ~= 'directory' then
						return false
					elseif a.type ~= 'directory' and b.type == 'directory' then
						return true
					end

					return a.name < b.name
				end)
			end,

			view = {
				number = true,
				relativenumber = true,
				width = {},
				float = {
					enable = true,
					open_win_config = function()
						return {
							border = 'none',
							relative = 'editor',
							height = 100,
							row = 0,
							width = 30,
							col = vim.opt.columns:get(),
						}
					end,
				},
			},

			renderer = {
				highlight_git = 'all',
				add_trailing = true,
				group_empty = true,
				indent_width = 4,
				indent_markers = {
					enable = true,
					icons = {
						corner = '└',
						edge = '│',
						item = '│',
						bottom = ' ',
						none = ' ',
					},
				},
				icons = {
					git_placement = 'after',
					modified_placement = 'before',
					glyphs = {
						git = {
							ignored = ' ',
						},
					},
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

			filters = {
				git_ignored = false,
			},
		},

		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},

	{
		'antosha417/nvim-lsp-file-operations',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-tree.lua',
		},
		config = function()
			require('lsp-file-operations').setup()
		end,
	},
}
