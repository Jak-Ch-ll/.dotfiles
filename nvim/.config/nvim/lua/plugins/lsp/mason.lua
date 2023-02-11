return {
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        config = true,
    },
    {
        dependencies = {
            'williamboman/mason.nvim',
        },
        'jay-babu/mason-null-ls.nvim',
        config = true,
    },
    -- Future: 'jay-babu/mason-nvim-dap.nvim'
}
