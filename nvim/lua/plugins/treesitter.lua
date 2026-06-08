-- On Windows tree-sitter defaults to MSVC (cl.exe); prefer gcc if present so
-- parser compilation works without a configured MSVC environment. No-op on Linux.
if vim.fn.has("win32") == 1 and vim.fn.executable("gcc") == 1 then
    vim.env.CC = "gcc"
end

local treesitter = require("nvim-treesitter")

local ensure_installed = {
    "c", "cpp", "lua", "bash", "json", "markdown",
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end

		pcall(vim.treesitter.start, buf, lang)
	end,
})
