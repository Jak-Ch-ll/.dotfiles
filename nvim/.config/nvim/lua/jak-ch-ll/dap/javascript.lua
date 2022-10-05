require("dap-vscode-js").setup({
    -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    node_path = "vite-node",

    -- Path to vscode-js-debug installation
    debugger_path = "/home/jchill/.local/share/nvim/mason/packages/js-debug-adapter",

    -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    -- debugger_cmd = { "js-debug-adapter" },

    -- which adapters to register in nvim-dap
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
