-- links:
-- https://github.com/mfussenegger/nvim-dap
--
return {
	'mfussenegger/nvim-dap',
	enabled = false,
	dependencies = {
		'mxsdev/nvim-dap-vscode-js',
		'theHamsta/nvim-dap-virtual-text',
		'rcarriga/nvim-dap-ui',
	},
	keys = {

		{
			'<F5>',
			function()
				-- require("dap.ext.vscode").load_launchjs(nil, { edge = { "typescript" } })
				print("I'm debugging!")
				-- require("dap.ext.vscode").load_launchjs()
				require('dap').continue()
			end,
			desc = '[F5] Continue',
		},
		{ '<F1>', ':lua require("dap").step_into()<CR>' },
		{ '<F2>', ':lua require("dap").step_over()<CR>' },
		{ '<F3>', ':lua require("dap").step_out()<CR>' },
		{ '<leader>tb', ':lua require("dap").toggle_breakpoint()<CR>' },
		{
			'<leader>tB',
			':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
		},
		{
			'<leader>lp',
			':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
		},
	},
	init = function()
		print('dap setup')
		require('nvim-dap-virtual-text').setup({})
		require('dapui').setup()

		-- open and close dap-ui automatically
		local dap = require('dap')
		local dapui = require('dapui')
		dap.listeners.after.event_initialized['dapui_config'] = function()
			dapui.open({})
		end
		dap.listeners.before.event_terminated['dapui_config'] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited['dapui_config'] = function()
			dapui.close({})
		end

		-- require("dap-vscode-js").setup({
		--     adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
		--     debugger_cmd = { "js-debug-adapter" },
		-- })
		--
		-- for _, language in ipairs({ "typescript", "javascript" }) do
		--     require("dap").configurations[language] = {
		--         {
		--             type = "pwa-node",
		--             request = "launch",
		--             name = "Launch file",
		--             program = "${file}",
		--             cwd = "${workspaceFolder}",
		--         },
		--         {
		--             type = "pwa-node",
		--             request = "attach",
		--             name = "Attach",
		--             processId = require 'dap.utils'.pick_process,
		--             cwd = "${workspaceFolder}",
		--         }
		--     }
		--
		-- end

		dap.adapters['pwa-node'] = {
			type = 'server',
			host = 'localhost',
			port = '${port}',
			executable = {
				command = 'js-debug-adapter',
				args = { '${port}' },
			},
		}

		dap.adapters['pwa-msedge'] = {
			type = 'server',
			-- host = "172.17.32.1",
			host = 'DESKTOP-MFFQGHD.local',
			-- host = "localhost",
			port = '${port}',
			executable = {
				command = 'js-debug-adapter',
				args = { '${port}' },
			},
		}

		dap.adapters['edge'] = {
			type = 'server',
			-- host = "172.17.32.1",
			-- host = "${env:hostname}.local",
			host = 'DESKTOP-MFFQGHD.local',
			-- host = "localhost",
			port = '${port}',
			executable = {
				command = 'js-debug-adapter',
				args = { '${port}' },
			},
		}

		dap.adapters['chrome'] = {
			type = 'server',
			-- host = "172.17.32.1",
			host = 'localhost',
			port = '${port}',
			executable = {
				command = 'js-debug-adapter',
				args = { '${port}' },
			},
		}

		for _, language in ipairs({ 'typescript', 'javascript' }) do
			dap.configurations[language] = {
				{
					type = 'edge',
					request = 'attach',
					port = 9222,
					name = 'Attach to Edge',
					-- hostName = "${env:hostname}.local",
					-- url = "http://localhost:5173/*",
					-- webRoot = "${workspaceFolder}",
				},
				{
					type = 'pwa-node',
					request = 'launch',
					name = 'Launch file',
					program = '${file}',
					runtimeExecutable = 'vite-node',
					cwd = '${workspaceFolder}',
				},
				{
					type = 'pwa-node',
					request = 'attach',
					name = 'Attach',
					processId = require('dap.utils').pick_process,
					cwd = '${workspaceFolder}',
				},
			}
		end

		-- dap.configurations.typescript = {
		--     {
		--         type = "pwa-node",
		--         request = "launch",
		--         name = "Launch file",
		--         program = "${file}",
		--         runtimeExecutable = "vite-node",
		--         cwd = "${workspaceFolder}",
		--     },
		-- }

		-- require("dap-vscode-js").setup({
		--     node_path = "vite-node",
		--     debugger_cmd = { "js-debug-adapter" },
		--     adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
		-- })

		-- for _, language in ipairs({ "typescript", "javascript" }) do
		--     dap.configurations[language] = {
		--         {
		--             type = "pwa-node",
		--             request = "launch",
		--             name = "Launch file",
		--             program = "${file}",
		--             runtimeExecutable = "vite-node",
		--             cwd = "${workspaceFolder}",
		--         },
		--         {
		--             type = "pwa-node",
		--             request = "attach",
		--             name = "Attach",
		--             processId = require 'dap.utils'.pick_process,
		--             cwd = "${workspaceFolder}",
		--         }
		--     }
		-- end

		-- require("dap-vscode-js").setup({
		--     debugger_cmd = { "js-debug-adapter" },
		-- })
		--
		--
		-- for _, language in ipairs({ "typescript", "javascript" }) do
		--     dap.configurations[language] = {
		--         {
		--             type = "pwa-node",
		--             request = "launch",
		--             name = "Launch file",
		--             program = "${file}",
		--             runtimeExecutable = "vite-node",
		--             cwd = "${workspaceFolder}",
		--         },
		--         {
		--             type = "pwa-node",
		--             request = "attach",
		--             name = "Attach",
		--             processId = require 'dap.utils'.pick_process,
		--             cwd = "${workspaceFolder}",
		--         }
		--     }
		-- end
	end,
}
