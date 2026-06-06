-- Entry point. Load order matters:
--   options first (termguicolors before the UI plugins draw),
--   then plugins (which loads the colorscheme, UI, finder, completion,
--   git, editor, treesitter, and lsp groups).
require("vim._core.ui2").enable({})

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("plugins")
