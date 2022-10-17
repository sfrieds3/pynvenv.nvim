local utils = {}

local pynvenv = require("pynvenv")
local config = require("pynvenv.config")

-- get project root
-- @param path of project to determine root
-- return project root
utils.find_project_root = function(path)
  print("find_project_root(" .. path .. ")")
end

-- if default_venv specified in config, set it
-- return none
utils.set_default_venv = function()
  local venv = require("pynvenv.config").opts.default_venv
  require("pynvenv").workon(vim.fn.expand(venv))
end

-- deactivate current venv
utils.deactivate = function()
  vim.env.pydoc = nil
  if vim.env.OLD_VIRTUAL_PATH then
    vim.env.PATH = vim.env.OLD_VIRTUAL_PATH
    vim.env.OLD_VIRTUAL_PATH = nil
  end

  if vim.env.OLD_VIRTUAL_PYTHONHOME then
    vim.env.PYTHONHOME = vim.env.OLD_VIRTUAL_PYTHONHOME
    vim.env.OLD_VIRTUAL_PYTHONHOME = nil
  end

  vim.env.VIRTUAL_ENV = nil

  pynvenv.current_venv = nil
end

-- set new active venv
-- @param venv absolute, relative, or alias of venv to activate
-- return nil
utils.activate = function(venv)
  if vim.env.VIRTUAL_ENV then
    -- TODO we can probably just swap over the venv here
    print("ERROR: " .. pynvenv.current_venv .. " venv already activated!")
    return
  end
  local venv_path = pynvenv.get_venv_path(venv)
  local venv_bin = pynvenv.get_venv_bin(venv)

  utils.deactivate()
  vim.env.VIRTUAL_ENV = venv_path
  vim.env.OLD_VIRTUAL_PATH = vim.env.PATH
  vim.env.PATH = venv_bin .. ":" .. vim.env.PATH
  if vim.env.PYTHONHOME then
    vim.env.OLD_VIRTUAL_PYTHONHOME = vim.env.PYTHONHOME
    vim.env.PYTHONHOME = nil
  end

  pynvenv.current_venv = venv
end

return utils
