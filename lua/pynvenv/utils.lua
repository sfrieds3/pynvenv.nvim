local utils = {}

local config = require("pynvenv.config")

utils.current_venv = nil

--- get project root
---@param path string project path to determine root
-- return project root
function utils.find_project_root(path)
  print("find_project_root(" .. path .. ")")
end

--- deactivate current venv
function utils.deactivate()
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
  utils.current_venv = nil
end

--- set new active venv
---@param venv_path string fully-qualified of venv to activate
function utils.activate(venv_path)
  local venv_bin = venv_path .. "/bin"
  if vim.fn.isdirectory(venv_bin) == nil then
    print("ERROR: " .. venv_bin .. " is not a valid venv location.")
    return
  end

  utils.deactivate()
  vim.env.VIRTUAL_ENV = venv_path
  vim.env.OLD_VIRTUAL_PATH = vim.env.PATH
  vim.env.PATH = venv_bin .. ":" .. vim.env.PATH
  if vim.env.PYTHONHOME then
    vim.env.OLD_VIRTUAL_PYTHONHOME = vim.env.PYTHONHOME
    vim.env.PYTHONHOME = nil
  end
  utils.current_venv = venv_path
end

--- if default_venv specified in config, set it
function utils.set_default_venv()
  local venv = config.opts.default_venv
  if venv and venv ~= "" then
    utils.activate(vim.fn.expand(venv))
  else
    print("No default venv configured.")
  end
end

return utils
