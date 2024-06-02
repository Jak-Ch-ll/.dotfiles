---@diagnostic disable: undefined-global

return {
	s('trig1', t('hello')),
	s('trig2', t('bye')),
	s('s', fmta("s('<>')", { i(1) })),
}
