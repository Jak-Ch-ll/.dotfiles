local prettier = { "prettier" }

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            javascript = prettier,
            typescript = prettier,
            typescriptreact = prettier,
            vue = prettier,

            html = prettier,
            css = prettier,
            scss = prettier,

            xml = prettier,
            yaml = prettier,
            json = prettier,
            jsonc = prettier,
            markdown = prettier,
        },
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },
    }
}