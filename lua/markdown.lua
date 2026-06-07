vim.pack.add({
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/folke/zen-mode.nvim'
})

require('render-markdown').setup({
    render_modes = { 'n', 'i', 'v' },
    anti_conceal = {
        -- enabled = false,
        disabled_modes = { 'n' }
    },
})

require("zen-mode").setup({
    window = {
        -- Lower numbers make text narrower and left/right margins wider
        width = 120, -- Fixed to 80 characters wide (standard for writing)

        -- ALTERNATIVELY, use a percentage / decimal value:
        -- width = 0.50, -- Takes up only 50% of screen width, leaving 50% for margins
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.schedule(function()
            vim.cmd("ZenMode")
        end)
        vim.keymap.set("n", "<leader>q", ":qa<CR>", { buffer = true, desc = "Quit file in 1 step" })
    end,
})


-- Automatically exit Zen Mode when leaving a markdown buffer
-- vim.api.nvim_create_autocmd("BufLeave", {
--     pattern = "markdown",
--     callback = function()
--         -- Check if zen-mode is currently active before toggling it off
--         local zen_view = package.loaded["zen-mode.view"]
--         if zen_view and zen_view.is_open() then
--             vim.cmd("ZenMode")
--         end
--     end,
-- })


local zen_markdown_group = vim.api.nvim_create_augroup("ZenMarkdownToggle", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = zen_markdown_group,
    pattern = "markdown",
    callback = function(ev)
        -- Current Markdown buffer identifier
        local md_buf = ev.buf

        -- 1. TRACK ENTERING: Re-activate ZenMode when returning to this buffer
        vim.api.nvim_create_autocmd("BufEnter", {
            group = zen_markdown_group,
            buffer = md_buf,
            callback = function()
                vim.schedule(function()
                    -- Confirm the buffer is still valid and ZenMode isn't already active
                    if vim.api.nvim_buf_is_valid(md_buf) then
                        local zen_view = package.loaded["zen-mode.view"]
                        if not (zen_view and zen_view.is_open()) then
                            vim.cmd("ZenMode")
                        end
                    end
                end)
            end,
        })

        -- 2. TRACK LEAVING: De-activate ZenMode when navigating away from this buffer
        vim.api.nvim_create_autocmd("BufLeave", {
            group = zen_markdown_group,
            buffer = md_buf,
            callback = function()
                local zen_view = package.loaded["zen-mode.view"]
                if zen_view and zen_view.is_open() then
                    vim.cmd("ZenMode")
                end
            end,
        })

        -- 3. Initial execution for the very first open
        vim.schedule(function()
            local zen_view = package.loaded["zen-mode.view"]
            if not (zen_view and zen_view.is_open()) then
                vim.cmd("ZenMode")
            end
        end)
    end,
})
