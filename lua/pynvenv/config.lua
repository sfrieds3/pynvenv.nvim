local config = {}

config.opts = {}
config.default_opts = {
  current_venv = nil,
  default_venv = nil,
  venv_aliases = {},
  project_roots = { ".git" },
  project_venv_dirs = { "venv", ".venv" },
  workon_home = vim.env.WORKON_HOME or nil,
  setup_commands = true,
}

--- return path to alias name as configured in venv_aliases
---@param venv string alias name
---@return string venv_path
function config.aliases(venv)
  return config.opts.venv_aliases[venv]
end

--- configure pynvenv
---@param opts table user configuration
function config.setup(opts)
  config.opts = vim.tbl_deep_extend("force", config.default_opts, opts or {})
end

return config
