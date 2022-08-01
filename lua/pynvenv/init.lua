local M = {}

M.current_venv = nil
M.current_venv_path = nil

M.setup = function(opts)
  require('pynvenv.config').setup(opts)
end

-- @param venv alias or qualified path to venv
-- get path to passed venv (either a path or alias)
local get_venv_path = function(venv)
  return require('pynvenv.config').aliases(venv)
end

-- @param venv alias or qualified path to venv
-- return bin dir of given venv
local function get_venv_bin(venv)
  local venv_dir = get_venv_path(venv)
  return string.format('%s/bin', venv_dir)
end

-- return path to curren venv
M.get_venv = function()
  return M.current_venv
end

-- deactivate current venv
M.deactivate = function()
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

  M.current_venv = nil
end

-- activate venv using either venv alias or qualified path
-- @param venv alias or qualified path to venv
-- return nil
M.workon = function(venv)
  if vim.env.VIRTUAL_ENV then
    -- TODO we can probably just swap over the venv here
    print('ERROR: ' .. M.current_venv .. ' venv already activated!')
    return
  end
  local venv_path = get_venv_path(venv)
  local venv_bin = get_venv_bin(venv)

  M.deactivate()
  vim.env.VIRTUAL_ENV = venv_path
  vim.env.OLD_VIRTUAL_PATH = vim.env.PATH
  vim.env.PATH = venv_bin .. ':' .. vim.env.PATH
  if vim.env.PYTHONHOME then
    vim.env.OLD_VIRTUAL_PYTHONHOME = vim.env.PYTHONHOME
    vim.env.PYTHONHOME = nil
  end

  M.current_venv = venv
end

-- activate venv in current directory
-- return nil
M.activate = function()
  -- TODO implement
  print('ERROR: activate not impleented yet...')
end

return M
