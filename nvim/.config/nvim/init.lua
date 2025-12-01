require("config.lazy")
local vimrc = vim.fn.stdpath("config") .. "/vim/vimrc"
vim.cmd.source(vimrc)

require("lsp.init")

vim.lsp.enable("bashls")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("omnisharp")
vim.lsp.enable("texlab")

