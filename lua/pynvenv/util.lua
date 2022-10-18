local util = {}

util.current_venv = nil
util.current_venv_path = nil

-- get project root
-- @param path of project to determine root
-- return project root
util.find_project_root = function(path)
  print("find_project_root(" .. path .. ")")
end

-- if default_venv specified in config, set it
-- return none
util.set_default_venv = function()
  local venv = require("pynvenv.config").opts.default_venv
  require("pynvenv").workon(vim.fn.expand(venv))
end

-- deactivate current venv
-- return none
util.deactivate = function()
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
  util.current_venv = nil
end

-- set new active venv
-- @param venv_path path of venv to activate
-- return nil
util.activate = function(venv_path)
  if vim.env.VIRTUAL_ENV then
    -- TODO we can probably just swap over the venv here
    print("ERROR: " .. util.current_venv .. " venv already activated!")
    return
  end

  local venv_bin = venv_path .. "/bin"
  if vim.fn.isdirectory(venv_bin) == nil then
    print("ERROR: " .. venv_bin .. " is not a valid venv location.")
    return
  end

  util.deactivate()
  vim.env.VIRTUAL_ENV = venv_path
  vim.env.OLD_VIRTUAL_PATH = vim.env.PATH
  vim.env.PATH = venv_bin .. ":" .. vim.env.PATH
  if vim.env.PYTHONHOME then
    vim.env.OLD_VIRTUAL_PYTHONHOME = vim.env.PYTHONHOME
    vim.env.PYTHONHOME = nil
  end
  util.current_venv = venv_path
end

return util
