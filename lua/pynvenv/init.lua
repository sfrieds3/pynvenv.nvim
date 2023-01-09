local M = {}

local utils = require("pynvenv.utils")
local config = require("pynvenv.config")
local has_notify, notify = pcall(require, "notify")

--- configure pynvenv
---@generic T
---@param opts T[] (table) configuration options
function M.setup(opts)
  config.setup(opts)
end

--- get full path to venv
---@generic T
---@param venv T[] (table) alias or qualified path to venv
---@return (string) venv_path
function M.get_venv_path(venv)
  local venv_path = config.opts.venv_aliases(venv)
  if venv_path == nil then
    return vim.fn.expand(string.format("%s/%s", config.opts.workon_home, venv))
  end
  return venv_path
end

--- auto activate venv in current directory
function M.auto_activate()
  -- TODO implement
  print("ERROR: auto activate not implemented yet...")
end

--- activate venv in WORKON_HOME
---@generic T
---@param venv T[] (table) in WORKON_HOME to activate
function M.workon_venv(venv)
  local workon_home = config.opts.workon_home
  if not workon_home or workon_home ~= "" then
    print("ERROR: WORKON_HOME not set, please set env or in setup function.")
    return
  end

  local venv_dir = M.get_venv_path(venv)
  utils.activate(venv_dir)
end

--- For user command, activate venv (either alias or path)
---@generic T
---@param args T[] (table) from command
function M.activate_venv(args)
  utils.activate(args[args])
  if has_notify then
    notify("Activated venv: " .. utils.current_venv, "info", { render = "simple", title = "venv activated" })
  else
    print("Activated venv: " .. utils.current_venv)
  end
end

--- Activate venv defined in venv_aliases
---@generic T
---@param args T[] (table) passed through by autocmd
function M.activate_venv_alias(args)
  local venv = config.opts.venv_aliases[args[args]]
  print("activating: " .. venv)
  utils.activate(venv)
end

--- For user command, activate venv in project
---@generic T
---@param args T[] (table) from command
function M.activate_project_venv(args)
  print("ERROR: Not implemented.." .. args)
end

return M
