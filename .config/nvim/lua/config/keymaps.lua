vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Remove search highlights" })

-- Primeagen-style movement and search ergonomics
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line and keep cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Clipboard/delete behavior used in Primeagen's setup
vim.keymap.set("x", "<leader>p", [['_dP]], { desc = "Paste over selection without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "Q", "<nop>")

local function spring_run()
	local cwd = vim.fn.getcwd()
	local cmd = nil

	if vim.fn.filereadable(cwd .. "/mvnw") == 1 then
		cmd = "./mvnw spring-boot:run"
	elseif vim.fn.executable("mvn") == 1 then
		cmd = "mvn spring-boot:run"
	else
		vim.notify("No Maven found. Use project mvnw or install maven.", vim.log.levels.ERROR)
		return
	end

	vim.cmd("botright 12split")
	vim.cmd("terminal " .. cmd)
	vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("SpringRun", spring_run, { desc = "Run Spring Boot" })
vim.keymap.set("n", "<leader>sr", spring_run, { desc = "[S]pring [R]un" })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle [U]ndotree" })
vim.keymap.set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

-- Common development keymaps

-- Save and quit
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite file" })
vim.keymap.set("n", "<leader>X", "<cmd>x<CR>", { desc = "Write and e[X]it" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "[Q]uit window" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force [Q]uit all" })

-- Better split management
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "[S]plit [H]orizontal" })
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "[S]plit [V]ertical" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<CR>", { desc = "[S]plit [C]lose" })


-- Resize windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize window left" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize window right" })

-- Buffers
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "[B]uffer [D]elete" })

-- Tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "[T]ab [N]ew" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "[T]ab [C]lose" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "[T]ab [O]nly" })
vim.keymap.set("n", "<leader>th", "<cmd>tabprevious<CR>", { desc = "[T]ab previous" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext<CR>", { desc = "[T]ab next" })

-- Terminal
local terminal_state = {
	buf = nil,
}

local function toggle_terminal_split()
	if terminal_state.buf and vim.api.nvim_buf_is_valid(terminal_state.buf) then
		local wins = vim.fn.win_findbuf(terminal_state.buf)
		if #wins > 0 then
			vim.api.nvim_win_close(wins[1], true)
			return
		end

		vim.cmd("botright 12split")
		vim.api.nvim_win_set_buf(0, terminal_state.buf)
		vim.cmd("startinsert")
		return
	end

	vim.cmd("botright 12split")
	vim.cmd("terminal")
	terminal_state.buf = vim.api.nvim_get_current_buf()
	vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>tt", toggle_terminal_split, { desc = "[T]oggle [T]erminal split" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })

-- Quick visual mode helpers
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Diagnostics and quickfix
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "[D]iagnostic [D]etails" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "[D]iagnostics to [L]ocation list" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })
vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "Quickfix next centered" })
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "Quickfix previous centered" })
vim.keymap.set("n", "<leader>J", "<cmd>lnext<CR>zz", { desc = "Location list next centered" })
vim.keymap.set("n", "<leader>K", "<cmd>lprev<CR>zz", { desc = "Location list previous centered" })

-- Telescope find/navigation helpers
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "[F]ind [H]elp" })

-- Harpoon quick access
local function with_harpoon(cb)
	local ok, harpoon = pcall(require, "harpoon")
	if not ok then
		vim.notify("Harpoon is not available yet", vim.log.levels.WARN)
		return
	end

	cb(harpoon)
end

vim.keymap.set("n", "<leader>a", function()
	with_harpoon(function(harpoon)
		harpoon:list():append()
	end)
end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<C-e>", function()
	with_harpoon(function(harpoon)
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end)
end, { desc = "Harpoon quick menu" })
vim.keymap.set("n", "<leader>1", function()
	with_harpoon(function(harpoon)
		harpoon:list():select(1)
	end)
end, { desc = "Harpoon file 1" })
vim.keymap.set("n", "<leader>2", function()
	with_harpoon(function(harpoon)
		harpoon:list():select(2)
	end)
end, { desc = "Harpoon file 2" })
vim.keymap.set("n", "<leader>3", function()
	with_harpoon(function(harpoon)
		harpoon:list():select(3)
	end)
end, { desc = "Harpoon file 3" })
vim.keymap.set("n", "<leader>4", function()
	with_harpoon(function(harpoon)
		harpoon:list():select(4)
	end)
end, { desc = "Harpoon file 4" })
