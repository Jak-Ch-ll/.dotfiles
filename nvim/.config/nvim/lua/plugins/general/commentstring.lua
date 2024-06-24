-- This plugin might become redundant in the future, because of the new built-in
-- commenting plugin that automatially uses Treesitter
--
-- Currently it solves 2 issues:
-- 1. It works with the template part of Vue files; currently the parses does
--    not seem do expose a commentstring
-- 2. It adds a space before the comments, which honestly is not super important
--    for commented out code and has a potential workaround:
--    https://github.com/neovim/neovim/pull/28176#issuecomment-2051944146
return {
	'JoosepAlviste/nvim-ts-context-commentstring',
	opts = {
		enable_autocmd = false,
	},
	init = function()
		-- Integrate  with built-it commenting plugin
		-- Keep an eye on https://github.com/JoosepAlviste/nvim-ts-context-commentstring/issues/109
		local get_option = vim.filetype.get_option
		---@diagnostic disable-next-line: duplicate-set-field
		vim.filetype.get_option = function(filetype, option)
			return option == 'commentstring'
					and require('ts_context_commentstring.internal').calculate_commentstring()
				or get_option(filetype, option)
		end
	end,
}
