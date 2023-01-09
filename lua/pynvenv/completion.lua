local completion = {}

local config = require("pynvenv.config").opts

--- similar to vim.tbl_filter, except filters by key
---@generic T
---@param func fun(value: T): boolean (function) predicate function
---@param t table(any, T) (table) table
---@return T[] (table) table of flitered values
local function tkey_filter(func, t)
  vim.validate({ func = { func, "c" }, t = { t, "t" } })

  local rettab = {}
  for key, entry in pairs(t) do
    if func(key) then
      table.insert(rettab, key)
    end
  end
  return rettab
end

--- completion for workon_venvs
---@generic T
---@param lead (string) characters
---@param _ (any) unused
---@return T[] (table) completion_candidates
function completion.workon_venvs(lead, _, _)
  local candidates = {}

  if config.workon_home == nil then
    return candidates
  end

  local dir_contents = vim.fn.readdir(vim.fn.expand(config.workon_home .. "/"))
  for _, folder in ipairs(dir_contents) do
    candidates[#candidates + 1] = folder
  end

  return vim.tbl_filter(function(venv)
    return vim.startswith(venv, lead)
  end, candidates)
end

--- completion for venv aliases
---@generic T
---@param lead (string) characters prompting for completion
---@param _ (any) unused
---@return T[] (table) completion_candidates
function completion.venv_aliases(lead, _, _)
  local candidates = config.venv_aliases

  if config.venv_aliases == nil then
    return candidates
  end

  P(candidates)

  return tkey_filter(function(venv)
    return vim.startswith(venv, lead)
  end, candidates)
end

P(completion.workon_venvs("v"))

return completion
