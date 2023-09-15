-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- url: https://github.com/kyazdani42/nvim-tree.lua

-- Keybindings are defined in `core/keymaps.lua`:
-- https://github.com/kyazdani42/nvim-tree.lua#keybindings

return {
	"kyazdani42/nvim-tree.lua",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	cmd = "NvimTreeToggle",
	opts = {
		hijack_cursor = true, -- keeps the cursor on the first letter of filename while navigating.
		hijack_unnamed_buffer_when_opening = true, -- Opens in place of the unnamed buffer if it's empty
	},
}
