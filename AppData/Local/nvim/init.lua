-- Windows Bridge init.lua
local unix_config_path = vim.fn.expand("~") .."/.config/nvim"

-- Add the unix path to Neovim's runtimepath so it can find your 'lua/' folder
vim.opt.runtimepath:prepend(unix_config_path)
vim.opt.packpath:prepend(unix_config_path)

-- Execute your actual init.lua
dofile(unix_config_path .. "/init.lua")
