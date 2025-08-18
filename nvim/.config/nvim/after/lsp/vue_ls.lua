---@type vim.lsp.Config
return {
	cmd = { 'bunx', '--bun', 'vue-language-server', '--stdio' },
	settings = {
		vue = {
			complete = {
				casing = {
					props = 'autoCamel',
				},
				autoInsert = {
					dotValue = true,
				},
			},
			inlayHints = {
				destructuredProps = true,
				missingProps = true,

				optionsWrapper = false,
				inlineHandlerLeading = false,
				vBindShorthand = false,
				includeInlayVariableTypeHints = false,
			},
		},
	},
	-- https://github.com/vuejs/language-tools/discussions/5603
	on_init = function(client)
		local retries = 0

		---@param _ lsp.ResponseError
		---@param result any
		---@param context lsp.HandlerContext
		local function handler(_, result, context)
			local ts_client = vim.lsp.get_clients({
				bufnr = context.bufnr,
				name = 'ts_ls',
			})[1] or vim.lsp.get_clients({
				bufnr = context.bufnr,
				name = 'vtsls',
			})[1]

			if not ts_client then
				if retries <= 10 then
					retries = retries + 1
					vim.defer_fn(function()
						handler(_, result, context)
					end, 100)
				else
					vim.notify(
						'Could not find `ts_ls` or `vtsls` lsp client, required by `vue_ls`.',
						vim.log.levels.ERROR
					)
				end
				return
			end

			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd({
				title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
				command = 'typescript.tsserverRequest',
				arguments = {
					command,
					payload,
				},
			}, { bufnr = context.bufnr }, function(_, r)
				local response_data = { { id, r and r.body } }
				---@diagnostic disable-next-line: param-type-mismatch
				client:notify('tsserver/response', response_data)
			end)
		end

		client.handlers['tsserver/request'] = handler
	end,
}
