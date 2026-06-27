require("transparency")
--require("tokyonight").setup({
--  transparent = true,
--})
vim.cmd.colorscheme("tokyonight")
require("transparency")

require("telescope").setup()
require("lualine").setup()
require("notify").setup({
  background_colour = "#000000",
})
require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
  },

  messages = {
    enabled = true,
  },

  popupmenu = {
    enabled = true,
  },
})
local ok, configs = pcall(require, "nvim-treesitter.configs")

if ok then
  configs.setup({
    highlight = {
      enable = true,
    },
  })
end
require("dashboard").setup({
  theme = "doom",

  config = {
    header = {
      "",
      "                                                                       ",
	"                                                                     ",
	"       ████ ██████           █████      ██                     ",
	"      ███████████             █████                             ",
	"      █████████ ███████████████████ ███   ███████████   ",
	"     █████████  ███    █████████████ █████ ██████████████   ",
	"    █████████ ██████████ █████████ █████ █████ ████ █████   ",
	"  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
	" ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
	"                                                                       ",
      "",
    },

    center = {
      {
        icon = "󰈞 ",
        desc = "Find File",
        key = "f",
        action = "Telescope find_files",
      },
      {
        icon = "󰊄 ",
        desc = "Recent Files",
        key = "r",
        action = "Telescope oldfiles",
      },
      {
	icon = "X ",
	desc = "Exit",
	key = "q",
	action = "q",
      },
      {
	icon = " ",
	desc = "Terminal",
	key = "t",
	action = "terminal"
      },
    },

    footer = {
      "",
      "",
    },
  },
})
-- disable netrw (important)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- keybind to toggle file tree
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })

-- neo-tree setup
require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = true,
    follow_current_file = {
      enabled = true,
    },
  },
})

vim.opt.autochdir = true

vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    vim.cmd("Neotree show")
  end,
})
