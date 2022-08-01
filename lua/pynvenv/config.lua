M = {}
M.opts = {}

M.default_opts = {
  current_venv = nil,
  default_venv = nil,
  venv_aliases = {},
  auto_venv = false,
  venv_roots = {}, -- TODO is this what we wnat to call it? 
  project_roots = { '.git' },  -- TODO figure out what other project roots we should use
}

-- @param venv alias or qualified path to venv
-- return path to venv alias if available
M.aliases = function(venv)
  return M.opts.venv_aliases.venv or venv
end

-- configure pynvenv
-- @param opts setup opts
-- return nil
M.setup = function(opts)
  M.opts = vim.tbl_deep_extend('force', M.default_opts, opts or {})

  if M.opts.default_venv then
    require('pynvenv.utils').set_default_venv()
  end
end

return M
