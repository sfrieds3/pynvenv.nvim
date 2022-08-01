local utils = {}

-- get project root
-- @param path of project to determine root
-- return project root
utils.find_project_root = function(path)
  print('find_project_root(' .. path .. ')')
end

-- if default_venv specified in config, set it
-- return none
utils.set_default_venv = function()
  local venv = require('pynvenv.config').opts.default_venv
  require('pynvenv').workon(vim.fn.expand(venv))
end

return utils
