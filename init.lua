-- 🧠 Auto-instala o packer se não existir
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 🔌 Carrega plugins
local status_plugins, _ = pcall(require, "hax.plugins")
if not status_plugins then
  vim.notify("Erro ao carregar plugins.lua", vim.log.levels.ERROR)
end

-- ⌨️ Carrega os atalhos personalizados
local status_keymaps, _ = pcall(require, "hax.keymaps")
if not status_keymaps then
  vim.notify("Erro ao carregar keymaps.lua", vim.log.levels.ERROR)
end

-- 🖥️ Carrega configuração do terminal
local status_terminal, _ = pcall(require, "hax.terminal")
if not status_terminal then
  vim.notify("Erro ao carregar terminal.lua", vim.log.levels.ERROR)
end


-- 🌈 Se quiser, aqui pode carregar opções e autocmds também
-- pcall(require, "hax.options")
-- pcall(require, "hax.autocmds")

-- 🔁 Sincroniza packer se foi instalado agora
if packer_bootstrap then
  require("packer").sync()
end
