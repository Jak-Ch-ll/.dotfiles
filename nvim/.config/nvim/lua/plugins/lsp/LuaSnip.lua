return {
	'L3MON4D3/LuaSnip',
	event = 'InsertEnter',

	-- dependencies = {
	-- 	{
	-- 		'nvim-cmp',
	-- 		dependencies = {
	-- 			'saadparwaiz1/cmp_luasnip',
	-- 		},
	-- 		opts = function(_, opts)
	-- 			local cmp = require('nvim-cmp')
	--
	-- 			opts.snippet = {
	-- 				expand = function(args)
	-- 					require('luasnip').lsp_expand(args.body)
	-- 				end,
	-- 			}
	--
	-- 			opts.mapping = cmp.mapping.preset.insert({
	-- 				['<Tab>'] = function(fallback)
	-- 					local luasnip = require('luasnip')
	--
	-- 					if cmp.visible() then
	-- 						cmp.confirm({ select = true })
	-- 					elseif luasnip.expand_or_locally_jumpable() then
	-- 						luasnip.expand_or_jump()
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end,
	-- 				['<S-Tab>'] = function(fallback)
	-- 					local luasnip = require('luasnip')
	--
	-- 					if luasnip.jumpable(-1) then
	-- 						luasnip.jump(-1)
	-- 					else
	-- 						fallback()
	-- 					end
	-- 				end,
	-- 				['<C-Space>'] = cmp.mapping.complete(),
	-- 			})
	-- 		end,
	-- 	}, },
	--

	config = function()
		require('luasnip.loaders.from_lua').lazy_load({
			lazy_paths = { './snippets' },
		})
		local ls = require('luasnip')
		local s = ls.snippet
		local sn = ls.snippet_node
		local isn = ls.indent_snippet_node
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		local c = ls.choice_node
		local d = ls.dynamic_node
		local r = ls.restore_node
		local events = require('luasnip.util.events')
		local ai = require('luasnip.nodes.absolute_indexer')
		local extras = require('luasnip.extras')
		local l = extras.lambda
		local rep = extras.rep
		local p = extras.partial
		local m = extras.match
		local n = extras.nonempty
		local dl = extras.dynamic_lambda
		local fmt = require('luasnip.extras.fmt').fmt
		local fmta = require('luasnip.extras.fmt').fmta
		local conds = require('luasnip.extras.expand_conditions')
		local postfix = require('luasnip.extras.postfix').postfix
		local types = require('luasnip.util.types')
		local parse = require('luasnip.util.parser').parse_snippet
		local ms = ls.multi_snippet
		local k = require('luasnip.nodes.key_indexer').new_key

		ls.add_snippets('all', {
			s('test', {
				t({ 'hello world' }),
			}),
		})
	end,
}
