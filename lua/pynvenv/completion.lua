local completion = {}

local config = require("pynvenv.config").opts

completion.workon_venvs = function(lead, _, _)
  local candidates = {}

  if config.workon_home == nil then
    return candidates
  end

  local dir_contents = vim.fn.readdir(vim.fn.expand(config.workon_home .. "/"))
  for _, folder in ipairs(dir_contents) do
    candidates[#candidates+1] = folder
  end

  return vim.tbl_filter(function(venv)
      return vim.startswith(venv, lead)
    end, candidates)
end

completion.venv_aliases = function(lead, _, _)
  local candidates = config..venv_aliases

  if config.venv_aliases == nil then 
    return candidates
  end

  return vim.tbl_filter(function(venv)
    return vim.startswith(venv, lead)
  end, candidates)
end

return completion
