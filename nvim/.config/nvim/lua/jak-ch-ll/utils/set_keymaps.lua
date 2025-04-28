---@class (exact) Keymapping
---@field [1] string lhs
---@field [2] string | fun() rhs
---@field desc? string desc
---@field mode? string | string[] mode
---@field opts? vim.keymap.set.Opts

---@class Options
---@field prefix? string prefix,
---@field buffer? number buffer,

---@param keymaps Keymapping[]
---@param shared_opts? Options
local function set_keymaps(keymaps, shared_opts)
	shared_opts = shared_opts or {}

	vim.iter(keymaps):each(
		---@param keymap Keymapping
		function(keymap)
			local lhs = keymap[1]
			local rhs = keymap[2]
			local mode = keymap.mode or 'n'
			local keymap_opts = keymap.opts or {}
			local desc = keymap.desc or 'MISSING DESCRIPTION'

			if shared_opts.prefix then
				desc = shared_opts.prefix .. desc
			end

			local final_opts = vim.tbl_deep_extend(
				'keep',
				{ desc = desc },
				keymap_opts,
				{ buffer = shared_opts.buffer }
			)

			vim.keymap.set(mode, lhs, rhs, final_opts)
		end
	)
end

return set_keymaps
