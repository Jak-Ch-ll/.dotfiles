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
		{ 'nvim-telescope/telescope-live-grep-args.nvim' },
	},
	keys = {
		{
			'<C-p>',
			custom_find_files,
			desc = '[C-p] Project files',
		},
		{
			'ff',
			custom_find_files,
			desc = '[F]ind [F]iles',
		},
		{
			'<leader><leader>',
			function()
				require('telescope.builtin').commands()
			end,
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
				require('telescope').extensions.live_grep_args.live_grep_args()
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
		local lga_actions = require('telescope-live-grep-args.actions')

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
					-- '--hidden',
				},
				layout_strategy = 'vertical',
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
			extensions = {
				-- https://github.com/nvim-telescope/telescope-live-grep-args.nvim#configuration
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					-- define mappings, e.g.
					mappings = { -- extend mappings
						i = {
							['<C-k>'] = lga_actions.quote_prompt(),
							['<C-i>'] = lga_actions.quote_prompt({
								postfix = ' --iglob ',
							}),
							-- freeze the current list and start a fuzzy search in the frozen list
							['<C-space>'] = lga_actions.to_fuzzy_refine,
						},
					},
					-- ... also accepts theme settings, for example:
					-- theme = "dropdown", -- use dropdown theme
					-- theme = { }, -- use own theme spec
					-- layout_config = { mirror=true }, -- mirror preview pane
				},
			},
		})
		telescope.load_extension('fzf')
		telescope.load_extension('file_browser')
		telescope.load_extension('harpoon')
		telescope.load_extension('live_grep_args')
	end,
}
