M = {}
M.opts = {}

M.default_opts = {
  default_venv = nil,
  auto_venv = false,
  venv_aliases = {},
}

local function set_default_venv()
  require('pynvenv').activate(vim.fn.expand(M.opts.default_venv))
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend('force', M.default_opts, opts or {})

  if M.opts.default_venv then
    set_default_venv()
  end
end

function M.aliases(venv)
  return M.opts.venv_aliases.venv or venv
end

return M
