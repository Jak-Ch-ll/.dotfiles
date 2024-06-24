local augroup = vim.api.nvim_create_augroup('format-on-save', { clear = true })

local function enable_format_on_save(client, buffer)
	if client.supports_method('textDocument/formatting') then
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = augroup,
			buffer = buffer,
			callback = function()
				vim.lsp.buf.format({
					filter = function(f_client)
						local exclude =
							{ 'tsserver', 'jsonls', 'volar', 'eslint' }

						for _, server in pairs(exclude) do
							if f_client.name == server then
								return false
							end
						end

						return true
					end,
				})
			end,
		})
	end
end

-- based on: https://github.com/neovim/neovim/issues/24305
local function enable_inlay_hints(client, bufnr)
	if not client.server_capabilities.inlayHintProvider then
		return
	end

	-- initially enabled
	local mode = vim.api.nvim_get_mode().mode
	vim.lsp.inlay_hint.enable(mode ~= 'i', { bufnr = bufnr })

	-- style
	vim.api.nvim_set_hl(0, 'LspInlayHint', { italic = true, fg = '#772277' })

	-- toggle command
	vim.api.nvim_create_user_command('ToggleInlayHint', function()
		vim.lsp.inlay_hint.enable(
			not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
			{ bufnr = bufnr }
		)
	end, {})

	-- auto enable/disable
	local inlay_hints_group =
		vim.api.nvim_create_augroup('InlayHints', { clear = false })
	vim.api.nvim_create_autocmd('InsertEnter', {
		group = inlay_hints_group,
		buffer = bufnr,
		callback = function()
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
		end,
	})
	vim.api.nvim_create_autocmd('InsertLeave', {
		group = inlay_hints_group,
		buffer = bufnr,
		callback = function()
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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

	-- nmap('<leader>r', vim.lsp.buf.rename, '[R]ename') // moved to inc-rename
	keymap(
		{ 'n', 'v' },
		'<leader>ca',
		vim.lsp.buf.code_action,
		'[C]ode [A]ction'
	)

	nmap('gh', vim.lsp.buf.hover, '[G]oto [H]over documentation')
	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('gr', function()
		require('telescope.builtin').lsp_references()
	end, '[G]oto [R]eferences')

	nmap('<leader>dn', vim.diagnostic.goto_next, '[D]iagnostics [N]ext')
	nmap('<leader>dp', vim.diagnostic.goto_prev, '[D]iagnostics [P]revious')
	nmap(
		'<leader>dh',
		vim.diagnostic.open_float,
		'[D]iagnostics [H]over information'
	)
	nmap('<leader>dl', function()
		require('telescope.builtin').diagnostics()
	end, '[D]iagnostics [L]ist')

	nmap('<leader>sds', function()
		require('telescope.builtin').lsp_document_symbols()
	end, '[S]earch [D]ocument [S]ymbols')
	nmap('<leader>sws', function()
		require('telescope.builtin').lsp_dynamic_workspace_symbols()
	end, '[S]earch [W]orkspace [S]ymbols')

	-- enable_format_on_save(client, bufnr)
end

return shared_on_attach
