local M = {}

function M.setup(opts)
  require('pynvenv.config').setup(opts)
end

local function get_venv_path(venv)
  return require('pynvenv.config').aliases(venv)
end

local function get_venv_bin(venv)
  local venv_dir = get_venv_path(venv)
  return string.format('%s/bin', venv_dir)
end

function M.deactivate()
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
end

function M.activate(venv)
  if vim.env.VIRTUAL_ENV then
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
end

return M
