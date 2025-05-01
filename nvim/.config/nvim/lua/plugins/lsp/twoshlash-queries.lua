vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('twoslash-queries', { clear = true }),
	pattern = '*.ts,*.vue',
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client.name ~= 'vtsls' then
			return
		end

		require('twoslash-queries').attach(client, args.buf)
	end,
})

return {
	'marilari88/twoslash-queries.nvim',
}
