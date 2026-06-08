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
