---@module 'lazy'
---@type LazySpec
return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	dependencies = {
		'nvim-treesitter/nvim-treesitter-context',
		{ 'windwp/nvim-ts-autotag', config = true, lazy = false },
	},
	config = function()
		local ts = require('nvim-treesitter')

		-- install all
		ts.install(ts.get_available())

		-- https://github.com/MeanderingProgrammer/treesitter-modules.nvim#implementing-yourself
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('treesitter.setup', {}),
			callback = function(args)
				local buf = args.buf
				local filetype = args.match

				local language = vim.treesitter.language.get_lang(filetype)
					or filetype
				if not vim.treesitter.language.add(language) then
					return
				end

				-- enable highlighting
				vim.treesitter.start(buf, language)

				vim.wo.foldmethod = 'expr'
				vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

				vim.bo[buf].indentexpr =
					"v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
	init = function()
		vim.filetype.add({
			extension = {
				mdx = 'markdown.mdx',
			},
		})
	end,
}
