vim.pack.add({
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/antoinemadec/FixCursorHold.nvim',
    'https://github.com/nvim-neotest/neotest',
    'https://github.com/nvim-neotest/neotest-go',
    'https://github.com/fredrikaverpil/neotest-golang',
})

require("neotest").setup({
    -- your neotest config here
    adapters = {
        require("neotest-golang")({
            runner = "gotestsum", -- or "gotestsum" if installed
            go_test_args = { "-v", "-count=1" },
            warn_test_name_dupes = false,
        }),
    },
    -- output_panel = {
    --     open = "botright vsplit | vertical resize 80",
    -- },
    output = {
        open_on_run = true,
        -- This table is passed directly to nvim_open_win()
        open_win = {
            -- Increase width and height (values between 0 and 1 are percentages of the screen)
            width = 0.8,   -- 80% of screen width
            height = 0.7,  -- 70% of screen height

            -- Optional visual preferences
            border = "rounded",
            relative = "editor",
            row = 5,
            col = 10,
        },
    },
    diagnostic = {
        enabled = true,
    }
})

vim.api.nvim_create_user_command('NeotestRun', function()
    require('neotest').run.run()
end, { desc = "Run nearest test with Neotest" })

vim.api.nvim_create_user_command('NeotestFile', function()
    require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run all tests in file with Neotest" })

vim.api.nvim_create_user_command('NeotestOutput', function()
    require("neotest").output.open({ enter = true })
end, { desc = "Display neotest output" })

vim.api.nvim_create_user_command('NeotestToggle', function()
    require("neotest").output_panel.toggle()
end, { desc = "Toggle neotest output" })
