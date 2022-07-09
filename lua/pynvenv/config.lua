M = {}

M.default_opts = {
  default_venv = nil,
  auto_venv = false,
}

M.opts = {}

function M.setup(opts)
  M.opts = vim.tbl_deep_extend('force', M.default_opts, opts or {})
end

return M
