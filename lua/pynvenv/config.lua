local config = {}
config.opts = {}

config.default_opts = {
  current_venv = nil,
  default_venv = nil,
  venv_aliases = {},
  auto_venv = false,
  venv_roots = {}, -- TODO is this what we wnat to call it?
  project_roots = { ".git" }, -- TODO figure out what other project roots we should use
  workon_home = vim.env.WORKON_HOME or nil
}

-- @param venv alias or qualified path to venv
-- return path to venv alias if available
config.aliases = function(venv)
  return config.opts.venv_aliases.venv
end

-- configure pynvenv
-- @param opts setup opts
-- return nil
config.setup = function(opts)
  config.opts = vim.tbl_deep_extend("force", config.default_opts, opts or {})

  if vim.env.VIRTUAL_ENV then
    require("pynvenv.util").current_venv = vim.env.VIRTUAL_ENV
  end

  if config.opts.default_venv then
    require("pynvenv.util").set_default_venv()
  end

  -- TODO should this override enviornment var?
  if opts.workon_home then
    vim.env.WORKON_HOME = opts.workon_home
  end

end

return config
