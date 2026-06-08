vim.pack.add { 'https://github.com/stevearc/oil.nvim' }
require("oil").setup({
    view_options = {
        show_hidden = true,
    }
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.pack.add { 'https://github.com/ibhagwan/fzf-lua' }
require('fzf-lua').setup({
    winopts = {
         preview = {
            hidden = true, -- Set to true to start with the preview window closed
            -- other options
        },
    },
    -- other configurations
})

vim.keymap.set("n", "<leader>l", ":FzfLua buffers<CR>", { desc = "Open buffer" })
vim.keymap.set("n", "<leader>f", ":FzfLua files<CR>", { desc = "Open FzfLua" })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.ERROR } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = { current_line = true }, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float {
                bufnr = bufnr,
                scope = 'cursor',
                focus = false,
            }
        end,
    },
}
