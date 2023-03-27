require("dap-vscode-js").setup({
    node_path = "vite-node",
    debugger_cmd = { "js-debug-adapter" },
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})


local dap = require('dap')

for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            runtimeExecutable = "vite-node",
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        }
    }
end

-- links:
-- https://github.com/mxsdev/nvim-dap-vscode-js
-- options: https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
