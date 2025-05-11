-- based on: https://github.com/neovim/neovim/issues/24305
local function enable_inlay_hints(client, bufnr)
	if not client.server_capabilities.inlayHintProvider then
		return
	end

	local already_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

	if already_enabled then
		return
	end

	-- initially enabled
	local mode = vim.api.nvim_get_mode().mode
	vim.lsp.inlay_hint.enable(mode ~= 'i', { bufnr = bufnr })

	-- style
	vim.api.nvim_set_hl(0, 'LspInlayHint', { italic = true, fg = '#772277' })

	local auto_toggle_enabled = true

	-- toggle command
	vim.api.nvim_create_user_command('ToggleInlayHint', function()
		local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })

		vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
		auto_toggle_enabled = not enabled
	end, {})

	-- auto enable/disable
	local inlay_hints_group =
		vim.api.nvim_create_augroup('InlayHints', { clear = false })
	vim.api.nvim_create_autocmd('InsertEnter', {
		group = inlay_hints_group,
		buffer = bufnr,
		callback = function()
			if auto_toggle_enabled then
				vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
			end
		end,
	})
	vim.api.nvim_create_autocmd('InsertLeave', {
		group = inlay_hints_group,
		buffer = bufnr,
		callback = function()
			if auto_toggle_enabled then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end,
	})
end

local function shared_on_attach(client, bufnr)
	enable_inlay_hints(client, bufnr)

	local function keymap(mode, keys, fn, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = desc })
	end

	local function nmap(keys, fn, desc)
		keymap('n', keys, fn, desc)
	end

	keymap(
		{ 'n', 'v' },
		'<leader>ca',
		vim.lsp.buf.code_action,
		'[C]ode [A]ction'
	)

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

	-- telescope
	nmap('gr', function()
		require('telescope.builtin').lsp_references()
	end, '[G]oto [R]eferences')
	nmap('<leader>sds', function()
		require('telescope.builtin').lsp_document_symbols()
	end, '[S]earch [D]ocument [S]ymbols')
	nmap('<leader>sws', function()
		require('telescope.builtin').lsp_dynamic_workspace_symbols()
	end, '[S]earch [W]orkspace [S]ymbols')
end

return shared_on_attach
