local filetypes = {
	'javascript',
	'typescript',
	'vue',
}

---@module 'lazy'
---@type LazySpec
return {
	'mfussenegger/nvim-lint',
	ft = filetypes,

	config = function()
		local lint = require('lint')

		lint.linters.eslint_d = require('lint.util').wrap(
			lint.linters.eslint_d,
			function(diagnostic)
				-- https://eslint.style/guide/faq#the-error-messages-squiggly-lines-for-code-style-are-annoying
				if diagnostic.code:find('^style/') then
					return
				end
				return diagnostic
			end
		)

		vim.api.nvim_create_autocmd({ 'InsertLeave', 'BufWritePost' }, {
			callback = function(event)
				if vim.list_contains(filetypes, vim.bo[event.buf].filetype) then
					lint.try_lint('eslint_d')
				end
			end,
		})
	end,
}
