local config = {}

local commands = require("pynvenv.commands")

config.opts = {}
config.default_opts = {
  current_venv = nil,
  default_venv = nil,
  venv_aliases = {},
  auto_venv = false,
  project_roots = { ".git" },
  project_venv_dirs = {},
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

  if vim.env.VIRTUAL_ENV then
    require("pynvenv.utils").current_venv = vim.env.VIRTUAL_ENV
  end

  if config.opts.default_venv then
    require("pynvenv.utils").set_default_venv()
  end

  -- TODO should this override enviornment var?
  if opts.workon_home then
    vim.env.WORKON_HOME = opts.workon_home
  end

  if config.opts.setup_commands then
    commands.create_user_commands()
  end
end

return config
