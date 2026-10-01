-- TexLab commands
vim.keymap.set("n", "<Localleader>ll", ":LspTexlabBuild<CR>", { buffer = true })
vim.keymap.set("n", "<Localleader>lv", ":LspTexlabForward<CR>", { buffer = true })

-- TeX-only: mini.surround custom LaTeX commands
local cfg = vim.b.minisurround_config or {}
cfg.custom_surroundings = cfg.custom_surroundings or {}

local function cmd_surround(cmd)
	return {
		input = { ("\\" .. cmd .. "{().-()}") },
		output = { left = ("\\" .. cmd .. "{"), right = "}" },
	}
end

-- LaTeX text commands
cfg.custom_surroundings.e = cmd_surround("emph") -- \emph{...}
cfg.custom_surroundings.b = cmd_surround("textbf") -- \textbf{...}
cfg.custom_surroundings.i = cmd_surround("textit") -- \textit{...}
cfg.custom_surroundings.t = cmd_surround("texttt") -- \texttt{...}
cfg.custom_surroundings.u = cmd_surround("underline") -- \underline{...}
cfg.custom_surroundings.s = cmd_surround("textsc") -- \textsc{...}

-- TeX-style double quotes
cfg.custom_surroundings.q = {
	input = { "``().-()''" },
	output = { left = "``", right = "''" },
}

vim.b.minisurround_config = cfg

local function open_pdf()
  local full_path = vim.fn.expand("%:p")
  local pdf_file = vim.fn.substitute(full_path, ".tex", ".pdf", "")
  vim.cmd("silent !sioyek '" .. pdf_file .. "' &")
end

vim.api.nvim_create_user_command('ZathuraOpen', open_pdf, {})

vim.keymap.set('n', '<localleader>lp', open_pdf, { desc = 'Открыть PDF в Sioyek' })


