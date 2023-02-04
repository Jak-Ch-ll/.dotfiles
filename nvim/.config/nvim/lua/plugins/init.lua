return {
    { import = 'plugins.lsp' },
    { import = 'plugins.general' },

    -- Misc
    { 'tpope/vim-surround', event = 'VeryLazy' },
    { 'lukas-reineke/indent-blankline.nvim', event = 'VeryLazy' },
    -- 'Raimondi/delimitMate',
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
