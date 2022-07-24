
local on_attach = function()
   local bufopts = { buffer = bufnr }
   vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
   vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
   vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

   -- jump to error (diagnostics)
   vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, bufopts)
   vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, bufopts)
   vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", bufopts)
   vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, bufopts)

   -- rename (will make changes in other files, use :wa to save)
   vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
end

local servers = { "tsserver", "gopls" }
  -- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        -- runs when this lsp is attaching to a buffer on opening
        capabilities = capabilities,
        on_attach = on_attach
    }
end

-- format on save
vim.api.nvim_create_augroup('on-save', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'on-save',
    callback = vim.lsp.buf.formatting
})

-- rust
require('rust-tools').setup({
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
    },
    tools = {
        inlay_hints = {
            parameter_hints_prefix = '<< ',
            other_hints_prefix = '>> '
        }
    }
})

-- inlay hints rust
--local lsp_extensions = require('lsp_extensions')
--vim.api.nvim_create_autocmd({
--    'CursorMoved',
--    'InsertLeave',
--    'BufEnter',
--    'BufWinEnter',
--    'TabEnter'
--}, {
--    pattern = '*.rs',
--    callback = function()
--        print("hello from cb")
--        lsp_extensions.inlay_hints{
--            enabled = { 'TypeHint', 'ChainingHint', 'ParameterHint'}
--        }
--    end
--})

-- Setup nvim-cmp.
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
})

