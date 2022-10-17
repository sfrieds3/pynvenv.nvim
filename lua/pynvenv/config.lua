local config = {}
config.opts = {}

config.default_opts = {
  current_venv = nil,
  default_venv = nil,
  venv_aliases = {},
  auto_venv = false,
  venv_roots = {}, -- TODO is this what we wnat to call it?
  project_roots = { ".git" }, -- TODO figure out what other project roots we should use
  workon_home = vim.env.WORKON_HOME or nil,
}

-- @param venv alias or qualified path to venv
-- return path to venv alias if available
config.aliases = function(venv)
  return config.opts.venv_aliases.venv or venv
end

-- configure pynvenv
-- @param opts setup opts
-- return nil
config.setup = function(opts)
  config.opts = vim.tbl_deep_extend("force", config.default_opts, opts or {})

  if config.opts.default_venv then
    require("pynvenv.utils").set_default_venv()
  end
end

return config
