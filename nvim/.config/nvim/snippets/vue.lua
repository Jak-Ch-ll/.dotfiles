---@diagnostic disable: undefined-global

return {
	s(
		'vue',
		fmt(
			[[ 
			<script setup lang="ts">
			{}
			</script>

			<template>
			  {}
			</template>
		]],
			{
				i(1),
				i(2),
			}
		)
	),
}
