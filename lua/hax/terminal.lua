-- -- Configura o terminal com Git Bash e atalhos CTRL-J
-- vim.o.shell = "/usr/bin/bash"
-- local terminal_open = false
-- local terminal_bufnr = nil
-- local terminal_winid = nil

-- -- Função pra abrir/fechar terminal embaixo
-- local function toggle_terminal()
--   if terminal_open and terminal_winid and vim.api.nvim_win_is_valid(terminal_winid) then
--     vim.api.nvim_win_close(terminal_winid, true)
--     terminal_open = false
--     terminal_bufnr = nil
--     terminal_winid = nil
--   else
--     vim.cmd("botright split term://bash")
--     vim.cmd("resize 15")
--     terminal_winid = vim.api.nvim_get_current_win()
--     terminal_bufnr = vim.api.nvim_get_current_buf()
--     terminal_open = true
--     vim.cmd("startinsert")
--   end
-- end

-- -- CTRL + jj => toggle terminal
-- vim.keymap.set("n", "<C-j><C-j>", toggle_terminal, { desc = "Toggle Terminal" })

-- -- CTRL + j => alternar entre terminal/editor
-- vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>w]], { noremap = true, desc = "Terminal → Editor" })
-- vim.keymap.set("n", "<C-j>", "<C-w>w", { noremap = true, desc = "Editor → Terminal" })
