local M = {}

local utils = require("pynvenv.utils")
local config = require("pynvenv.config")

M.current_venv = nil
M.current_venv_path = nil

M.setup = function(opts)
  config.setup(opts)
end

-- @param venv alias or qualified path to venv
-- get path to passed venv (either a path or alias)
M.get_venv_path = function(venv)
  return config.aliases(venv)
end

-- @param venv alias or qualified path to venv
-- return bin dir of given venv
M.get_venv_bin = function(venv)
  local venv_dir = M.get_venv_path(venv)
  return string.format("%s/bin", venv_dir)
end

-- return path to curren venv
M.get_venv = function()
  return M.current_venv
end

-- activate venv in current directory
-- return nil
M.auto_activate = function()
  -- TODO implement
  print("ERROR: activate not implemented yet...")
end

-- activate venv in WORKON_HOME
-- @param venv venv in WORKON_HOME to activate
-- return nil
M.workon = function(venv)
  -- TODO implement
  local workon_home = config.workon_home
  if not workon_home then
    print("ERROR: WORKON_HOME not set, please set env or in setup function.")
    return
  end

  print("ERROR: workon not implemented")
end

return M
