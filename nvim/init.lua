-- Entry point. Load order matters:
--   options first (termguicolors before the UI plugins draw),
--   then plugins (which loads the colorscheme, UI, finder, completion,
--   git, editor, treesitter, and lsp groups).
-- experimental ui2 messages/cmdline UI (internal API → guard against future renames)
pcall(function() require("vim._core.ui2").enable({}) end)

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("plugins")
