return {
	'nvim-lualine/lualine.nvim',
	lazy = false,
	dependencies = {
		{
			'nvim-tree/nvim-web-devicons',
			opts = {
				default = true,
				icons_enabled = true,
			},
		},
		{ 'AndreM222/copilot-lualine' },
	},
	config = function()
		local custom_filename = require('lualine.components.filename'):extend()

		local function buf_number()
			local current_buf = vim.api.nvim_get_current_buf()
			return current_buf .. ': '
		end

		local function is_empty(str)
			if str == nil or str == '' then
				return true
			end

			return false
		end

		local function current_folder()
			local path = vim.api.nvim_buf_get_name(0)

			local filename_matcher = '/[^/]+$'

			path = path:gsub(filename_matcher, '')

			if is_empty(path) then
				return ''
			end

			local foldername = string.match(path, '[^/]+$')

			if is_empty(foldername) then
				return ''
			end

			return '(' .. foldername .. ') '
		end

		function custom_filename:update_status()
			local data = custom_filename.super.update_status(self)
			--
			local foldername = current_folder()

			return buf_number() .. foldername .. data
		end

		local function filename()
			return {
				custom_filename,
				newfile_statue = true,
				symbols = {
					modified = '•',
				},
			}
		end

		-- Show macro recording status in lualine
		-- https://github.com/folke/noice.nvim/wiki/A-Guide-to-Messages#showmode
		local function status()
			return {
				require('noice').api.statusline.mode.get,
				cond = require('noice').api.statusline.mode.has,
			}
		end
		-- we don't want to see the mode
		vim.o.showmode = false

		require('lualine').setup({
			options = {
				icons_enabled = true,
				ignore_focus = {
					'TelescopePrompt',
					'NvimTree',
					'help',
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {
					'branch',
					'diagnostics',
				},
				lualine_c = {
					filename(),
					status(),
				},
				lualine_x = {
					'filetype',
					'progress',
					'location',
				},
				lualine_y = {
					{ 'copilot', show_colors = true },
				},
				lualine_z = {},
			},
		})
	end,
}
