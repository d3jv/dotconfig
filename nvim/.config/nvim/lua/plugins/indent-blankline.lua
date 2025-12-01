return {
	"lukas-reineke/indent-blankline.nvim",
	version = "*",
	opts = {
		char = '│',
		space_char_blankline = ' ',
		show_current_context = true,
		show_current_context_start = false,
		use_treesitter = true,
		context_patterns = { 'class', 'function', 'method' },
		filetype_exclude = { 'help', 'packer', 'nvimtree', 'dashboard', 'neo-tree' },
		buftype_exclude = { 'terminal', 'nofile', 'quickfix' },
		max_indent_increase = 1,
		show_trailing_blankline_indent = false,
	}
}

