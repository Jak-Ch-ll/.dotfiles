return {
    { 'tpope/vim-surround', lazy = false },
    'Raimondi/delimitMate',
    'lukas-reineke/indent-blankline.nvim',
    'stephenway/postcss.vim',

    -- dap
    { 'mfussenegger/nvim-dap',
        dependencies = {
            "mxsdev/nvim-dap-vscode-js",
            'theHamsta/nvim-dap-virtual-text',
            "rcarriga/nvim-dap-ui"
        }
    },
}
