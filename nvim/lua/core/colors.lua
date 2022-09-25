-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------


local onenord_ok, onenord = pcall(require, "onenord")
if onenord_ok then
	vim.api.nvim_command("colorscheme onenord")
end

local material_ok, material = pcall(require, "material")
if material_ok then
	vim.g.material_style = "palenight"
	vim.api.nvim_command("colorscheme material")
end
