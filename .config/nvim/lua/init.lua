local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

-- Plugins
require('packer').startup(function(use)
	use "wbthomason/packer.nvim"

	use "andweeb/presence.nvim"
	use "glepnir/dashboard-nvim"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/nvim-cmp"
	use "jose-elias-alvarez/null-ls.nvim"
	use "L3MON4D3/LuaSnip"
	use "lewis6991/gitsigns.nvim"
	use "nvim-lualine/lualine.nvim"
	use "nvim-telescope/telescope.nvim"
	use "nvim-treesitter/nvim-treesitter"
	use "onsails/lspkind-nvim"
	use "ryanoasis/vim-devicons"
	use "saadparwaiz1/cmp_luasnip"
	use "tpope/vim-commentary"
	use "williamboman/nvim-lsp-installer"
	use "windwp/nvim-autopairs"
	use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
	use "ellisonleao/gruvbox.nvim"
	use {"akinsho/toggleterm.nvim", tag = 'v2.*', config = function() require("toggleterm").setup() end}
	use {"https://github.com/nvim-neo-tree/neo-tree.nvim", 
			branch = "v2.x", 
			requires = { 
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
	  		}
		}
	use {"ray-x/navigator.lua",
			requires = {
				{ "ray-x/guihua.lua", run = "cd lua/fzy && make" },
				{ "neovim/nvim-lspconfig" },
			}
		}
	use "https://github.com/famiu/bufdelete.nvim"
	use "https://github.com/mrjones2014/smart-splits.nvim"
	use "https://github.com/numToStr/Comment.nvim"
	use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
	use "https://github.com/p00f/nvim-ts-rainbow"
end)

-- Vim config
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.lazyredraw = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.shiftwidth = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.updatetime = 100
vim.o.background = "dark"
vim.o.mouse = "a"
vim.o.ignorecase = true
vim.o.fileencoding = true
vim.o.scrolloff = 8
vim.o.showmode = false
vim.o.writebackup = false
vim.o.fileencoding = "utf-8"

vim.cmd([[colorscheme gruvbox]])

-- Map leader to space
vim.g.mapleader = " "

local map = require("utils").map
-- General key binds
map("n", "<Leader>w", ":w<CR>", { desc = "Write" })
map("n", "<Leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<Leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search" })
map("n", "<Leader>f", "<cmd>Telescope find_files<cr>", { desc = "Open find" })

-- Terminal
map("n", "<Leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open floating terminal" })
map("n", "<Leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Open horizontal terminal" })
map("n", "<Leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Open vertical termainl" })
map("t", "<esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
map("t", "<C-h>", "<c-\\><c-n><c-w>h", { desc = "Terminal left window navigation" })
map("t", "<C-j>", "<c-\\><c-n><c-w>j", { desc = "Terminal down window navigation" })
map("t", "<C-k>", "<c-\\><c-n><c-w>k", { desc = "Terminal up window navigation" })
map("t", "<C-l>", "<c-\\><c-n><c-w>l", { desc = "Terminal right window navigation" })

-- NeoTree
map("n", "<Leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })
map("n", "<Leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus neotree" })

-- Edit nvim configuration
map("n", "<Leader>v", ":edit ~/.config/nvim/init.lua<CR>", { silent = true, desc = "Open neovim init.lua to edit" })

-- Buffers
map("n", "<Leader>c", "<cmd>Bdelete<cr>", { desc = "Close current buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer tab" })
map("n", ">b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer tab right" })
map("n", "<b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer tab left" })

-- Window navitaion
map("n", "<C-h>", "", { callback = function() require("smart-splits").move_cursor_left() end, desc = "Move to split left" })
map("n", "<C-j>", "", { callback = function() require("smart-splits").move_cursor_down() end, desc = "Move to split below" })
map("n", "<C-k>", "", { callback = function() require("smart-splits").move_cursor_up() end, desc = "Move to split above" })
map("n", "<C-l>", "", { callback = function() require("smart-splits").move_cursor_right() end, desc = "Move to split right" })

-- Resize with arrows
map("n", "<C-Up>", "", { callback = function() require("smart-splits").resize_up() end, desc = "Resize split up" })
map("n", "<C-Down>", "", { callback = function() require("smart-splits").resize_down() end, desc = "Resize split down" })
map("n", "<C-Left>", "", { callback = function() require("smart-splits").resize_left() end, desc = "Resize split left" })
map("n", "<C-Right>", "", { callback = function() require("smart-splits").resize_right() end, desc = "Resize split right" })

-- Commenting
map("n", "<Leader>/", "", { callback =function() require("Comment.api").toggle_current_linewise() end, desc = "Comment line" })
map("v", "<Leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>", { desc = "Toggle comment line" })

-- Split window
map("n", "<Leader>sh", "<cmd>vsplit<cr>", { desc = "Split window horizontally" })
map("n", "<Leader>sv", "<cmd>split<cr>", { desc = "Split window verticall" })

-- Dashboard
local db = require "dashboard"
db.custom_header = {
	"",
	"",
	"",
	"",
	"░█████╗░██╗░░░██╗██╗███╗░░░███╗",
	"██╔══██╗██║░░░██║██║████╗░████║",
	"██║░░╚═╝╚██╗░██╔╝██║██╔████╔██║",
	"██║░░██╗░╚████╔╝░██║██║╚██╔╝██║",
	"╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║",
	"░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
	"",
	"",
	"",
}

db.custom_center = {
	{
		icon = " ",
		desc = "New File            ",
		action = "DashboardNewFile",
		shortcut = "SPC o",
	},
	{
		icon = " ",
		desc = "Browse Files        ",
		action = "Telescope file_browser",
		shortcut = "SPC n",
	},
	{
		icon = " ",
		desc = "Find File           ",
		action = "Telescope find_files",
		shortcut = "SPC f",
	},
	{
		icon = " ",
		desc = "Configure Neovim    ",
		action = "edit ~/.config/nvim/lua/init.lua",
		shortcut = "SPC v",
	},
	{
		icon = " ",
		desc = "Exit Neovim              ",
		action = "quit",
	},
}
map("n", "<Leader>o", ":DashboardNewFile<CR>", { silent = true })

-- LspServers
local servers = {
	"bashls",
	"clangd",
	"cssls",
	"gopls",
	"html",
}
for _, name in pairs(servers) do
	local found, server = require("nvim-lsp-installer").get_server(name)
	if found and not server:is_installed() then
		print("Installing " .. name)
		server:install()
	end
end

-- Bufferline
require("bufferline").setup {
	options = {
    offsets = {
      { filetype = "NeoTree", text = "", padding = 1 },
      { filetype = "neo-tree", text = "", padding = 1 },
      { filetype = "Outline", text = "", padding = 1 },
    },
    buffer_close_icon = "x",
    modified_icon = "~",
    close_icon = "x",
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    separator_style = "thin",
  }
}

-- Lualine
require("lualine").setup {
	options = {
		theme = 'gruvbox_dark',
		component_separators = "|",
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
		lualine_b = { "filename", "branch", { "diff", colored = false } },
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "filetype", "progress" },
		lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				separator = { left = "", right = "" },
				right_padding = 2,
				symbols = { alternate_file = "" },
			},
		},
	},
}

-- Treesitter
require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"bash",
		"cpp",
		"c",
		"go",
		"lua",
		"cmake",
		"make",
	},
	highlight = { enable = true },
	rainbow = { enabled = true, max_file_lines = nil }
}

-- Neotree
require("neo-tree").setup {
	close_if_last_window = true,
	popup_border_style = "rounded",
	enable_diagnostics = false,
	default_component_configs = {
		indent = {
			padding = 0,
			with_expanders = false,
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			default = "",
		},
		git_status = {
			symbols = {
				added = "",
				deleted = "",
				modified = "",
				renamed = "➜",
				untracked = "★",
				ignored = "◌",
				unstaged = "✗",
				staged = "✓",
				conflict = "",
			},
		},
	},
	window = {
		width = 25,
		mappings = {
			["o"] = "open",
		},
	},
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {
				".DS_Store",
				"thumbs.db",
				"node_modules",
				"__pycache__",
			},
		},
		follow_current_file = true,
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
	},
	git_status = {
		window = {
		position = "float",
		},
	},
	event_handlers = {
		{ event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
	}
}

-- Tooglterm
require("toggleterm").setup {
	size = 10,
	open_mapping = [[<c-\>]],
	shading_factor = 2,
	direction = "float",
	float_opts = {
	border = "curved",
	highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
}


