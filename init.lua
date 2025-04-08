-- 🧠 Auto-instala o packer se não existir
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 🧩 Plugins
local plugins_ok, _ = pcall(require, "hax.plugins")
if not plugins_ok then
  vim.notify("❌ Falha ao carregar hax.plugins", vim.log.levels.ERROR)
end

-- 🎛️ Keymaps
local keymaps_ok, _ = pcall(require, "hax.keymaps")
if not keymaps_ok then
  vim.notify("❌ Falha ao carregar hax.keymaps", vim.log.levels.ERROR)
end

-- ⚙️ Carrega options e autocmds (se quiser usar)
pcall(require, "hax.options")
pcall(require, "hax.autocmds")

-- 🔁 Sincroniza plugins se packer foi recém-instalado
if packer_bootstrap then
  require("packer").sync()
end
