return {
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim"
		},
        keys = {
            {"<leader>n", ":Telescope file_browser<CR>"}
        }
	}
}
