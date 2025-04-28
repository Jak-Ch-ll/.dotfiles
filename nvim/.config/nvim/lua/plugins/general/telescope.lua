local function custom_find_files()
	vim.fn.system('git rev-parse --is-inside-work-tree')

	print('Error: ', vim.v.shell_error)

	if vim.v.shell_error == 0 then
		require('telescope.builtin').git_files({
			show_untracked = true,
		})
	else
		require('telescope.builtin').find_files()
	end
end

return {
	'nvim-telescope/telescope.nvim',
	name = 'Telescope',
	cmd = 'Telescope',
	dependencies = {
		{ 'nvim-lua/plenary.nvim' },
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		{ 'nvim-telescope/telescope-file-browser.nvim' },
	},
	keys = {
		{
			'<C-p>',
			custom_find_files,
			desc = '[C-p] Project files',
		},
		{
			'<leader>sc',
			function()
				require('telescope.builtin').commands()
			end,
			desc = '[S]earch [C]ommands',
		},
		{
			'<leader>/',
			function()
				require('telescope.builtin').current_buffer_fuzzy_find(
					require('telescope.themes').get_dropdown({
						winblend = 10,
						previewer = false,
					})
				)
			end,
			desc = '[/] Fuzzily search in current buffer]',
		},
		{
			'<leader>b',
			function()
				require('telescope.builtin').buffers()
			end,
			desc = '[B]uffers',
		},
		{
			'<leader>sh',
			function()
				require('telescope.builtin').help_tags()
			end,
			desc = '[S]earch [H]elp',
		},
		{
			'<leader>sw',
			function()
				require('telescope.builtin').grep_string()
			end,
			desc = '[S]earch current [W]ord',
		},
		{
			'<leader>sg',
			function()
				require('telescope.builtin').live_grep()
			end,
			desc = '[S]earch by [G]rep',
		},
		{
			'<leader>sd',
			function()
				require('telescope.builtin').diagnostics()
			end,
			desc = '[S]earch [D]iagnostics',
		},
		{
			'<leader>sk',
			function()
				require('telescope.builtin').keymaps()
			end,
			desc = '[S]earch [K]eymaps',
		},
	},
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					-- default
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',

					-- custom changes
					'--hidden',
				},
			},
			pickers = {
				buffers = {
					mappings = {
						n = {
							['x'] = actions.delete_buffer,
						},
					},
				},
				lsp_references = {
					theme = 'dropdown',
					include_current_line = true,
					show_line = false,
					trim_text = true,
				},
			},
		})
		telescope.load_extension('fzf')
		telescope.load_extension('file_browser')
		telescope.load_extension('harpoon')
	end,
}
