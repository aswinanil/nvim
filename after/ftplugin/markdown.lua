vim.keymap.set("n", "<leader>q", ":qa<CR>", { buffer = true, desc = "Quit file in 1 step" })

local zen_markdown_group = vim.api.nvim_create_augroup("ZenMarkdownToggle", { clear = true })

-- Current Markdown buffer identifier
local md_buf = vim.api.nvim_get_current_buf()

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
