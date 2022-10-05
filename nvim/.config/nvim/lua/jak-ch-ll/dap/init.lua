require('jak-ch-ll.dap.javascript')

require("nvim-dap-virtual-text").setup({})
require("dapui").setup()

--local dap = require('dap')

vim.keymap.set('n', '<F5>',
    ':lua require("dap.ext.vscode").load_launchjs(nil, { ["pwa-node"] = { "typescript" } })<CR>:lua require("dap").continue()<CR>')

vim.keymap.set('n', '<F1>', ':lua require("dap").step_into()<CR>')
vim.keymap.set('n', '<F2>', ':lua require("dap").step_over()<CR>')
vim.keymap.set('n', '<F3>', ':lua require("dap").step_out()<CR>')

vim.keymap.set('n', '<leader>b', ':lua require("dap").toggle_breakpoint()<CR>')
vim.keymap.set('n', '<leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
vim.keymap.set('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')

-- open and close dap-ui automatically
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

-- links:
-- https://github.com/mfussenegger/nvim-dap
