return {
    'jubnzv/mdeval.nvim',
    cmd = 'MdEval',
    opts = {
        eval_options = {
            ts = {
                command = { "bun" },
                language_code = "ts",
                exec_type = "interpreted",
                extension = "ts",
            }
        }
    }
}
