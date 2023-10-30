local embedded_vue = vim.treesitter.query.parse(
    "typescript",
    [[
        (variable_declarator
            type: (type_annotation
                (type_identifier) @type (#eq? @type "Story")
            )
            value: (object
                (pair
                    key: (property_identifier) @render_key (#eq? @render_key "render")
                    value: (_
                        body: (_
                            (object
                                (pair
                                    key: (property_identifier) @template_key (#eq? @template_key "template")
                                    value: (template_string) @vue
                                )
                            )
                        )
                    )
                )
            )
        )
        ]]
)

local function get_root(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "typescript", {})
    local tree = parser:parse()[1]
    return tree:root()
end

local function format_embedded_vue(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    if vim.bo[bufnr].filetype ~= "typescript" then
        vim.notify("Can only be used in TypeScript files")
        return
    end

    local root = get_root(bufnr)

    local changes = {}
    for id, node in embedded_vue:iter_captures(root, bufnr, 0, -1) do
        -- print("iteration", id, node)
        local name = embedded_vue.captures[id]

        if name == 'vue' then
            -- { startRow, startCol, endRow, endCol }
            local range = { node:range() }

            local unformatted = vim.treesitter.get_node_text(node, bufnr)
            local result = vim.fn.system('prettierd index.html', unformatted)

            local lines = {}
            for line in string.gmatch(result, "([^\n]*)\n?") do
                table.insert(lines, line)
            end

            -- remove trailing empty line
            table.remove(lines)

            local indentation = string.rep(" ", 6)
            for idx, line in ipairs(lines) do
                if idx == table.maxn(lines) then
                    lines[idx] = '    ' .. line
                elseif idx ~= 1 then
                    lines[idx] = indentation .. line
                end
            end

            table.insert(changes, 1, {
                start_row = range[1],
                start_col = range[2],
                end_row = range[3],
                end_col = range[4],
                lines = lines
            })
        end
    end

    for _, change in ipairs(changes) do
        vim.api.nvim_buf_set_text(
            bufnr,
            change.start_row,
            change.start_col,
            change.end_row,
            change.end_col,
            change.lines
        )
    end
end


vim.api.nvim_create_user_command("VueStorybookFormat", function()
    format_embedded_vue()
end, {})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = vim.api.nvim_create_augroup('VueStorybookFormat', {}),
--     pattern = "*.stories.ts",
--     callback = function(event)
--         format_embedded_vue(event.buf)
--     end
-- })
