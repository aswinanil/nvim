vim.opt.runtimepath:append("~/.vim,~/.vim/after")
vim.opt.runtimepath:prepend("~/.vim")
vim.cmd.source("~/.vimrc")

vim.loader.enable()
vim.o.confirm = true

vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
})

require("config")
require("lsp")
require("completion")
require("testing")
require("markdown")
