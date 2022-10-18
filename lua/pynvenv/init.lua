local M = {}

local util = require("pynvenv.util")
local config = require("pynvenv.config")

M.setup = function(opts)
  config.setup(opts)
end

-- @param venv alias or qualified path to venv
-- get path to passed venv (either a path or alias)
M.get_venv_path = function(venv)
  local venv_path = config.aliases(venv)
  if venv_path == nil then
    return vim.fn.expand(string.format("%s/%s", config.opts.workon_home, venv))
  end
  return venv_path
end

-- auto activate venv in current directory
-- return nil
M.auto_activate = function()
  -- TODO implement
  print("ERROR: auto activate not implemented yet...")
end

-- activate venv in WORKON_HOME
-- @param venv venv in WORKON_HOME to activate
-- return nil
M.workon = function(venv)
  local workon_home = config.opts.workon_home
  if not workon_home then
    print("ERROR: WORKON_HOME not set, please set env or in setup function.")
    return
  end

  local venv_dir = M.get_venv_path(venv)
  util.activate(venv_dir)
end

-- For user command, activate venv in WORKON_HOME
-- @param args args from WorkonVenv command
-- return nil
local function workon_venv(args)
  M.workon(args.args)
end

-- For user command, activate venv (either alias or path)
-- @param args args from command
-- return nil
local function activate_venv(args)
  require("pynvenv.util").activate(args.args)
  print("Activated venv: " .. util.current_venv)
end

-- For user command, activate venv in project
-- @param args args from command
-- return nil
local function activate_project_venv(args)
  print("ERROR: Not implemented.." .. args)
end

vim.api.nvim_create_user_command("WorkonVenv", workon_venv, { bang = true, nargs = 1, complete = require("pynvenv.completion").workon_venvs, desc = "Activate venv in WORKON_HOME directory." })
vim.api.nvim_create_user_command("ActivateVenv", activate_venv, { bang = true, nargs = 1, desc = "Activate venv using either alias or fully qualified path." })
vim.api.nvim_create_user_command("ActivateVenvAlias", activate_venv, { bang = true, nargs = 1, complete = require("pynvenv.completion").venv_aliases, desc = "Activate venv using alias." })
vim.api.nvim_create_user_command("ActivateProjectVenv", activate_project_venv, { bang = true, desc = "Activate venv located in current project." })
vim.api.nvim_create_user_command("DeactivateVenv", require("pynvenv.util").deactivate, { bang = true, desc = "Deactivate currently activated venv." })

return M
