local M = {}

--- create user commands for command pynvenv actions
function M.create_user_commands()
  local pynvenv = require("pynvenv")
  local utils = require("pynvenv.utils")
  local complete = require("pynvenv.completion")

  vim.api.nvim_create_user_command("PynvenvWorkonVenv", pynvenv.workon_venv, {
    nargs = 1,
    complete = complete.workon_venvs,
    desc = "Activate venv in WORKON_HOME directory.",
  })

  vim.api.nvim_create_user_command(
    "PynvenvActivateVenv",
    pynvenv.activate_venv,
    { bang = true, nargs = 1, desc = "Activate venv using either alias or fully qualified path." }
  )

  vim.api.nvim_create_user_command("PynvenvActivateVenvAlias", pynvenv.activate_venv_alias, {
    bang = true,
    nargs = 1,
    complete = complete.venv_aliases,
    desc = "Activate venv using alias.",
  })

  vim.api.nvim_create_user_command(
    "PynvenvActivateProjectVenv",
    pynvenv.activate_project_venv,
    { bang = true, desc = "Activate venv located in current project." }
  )

  vim.api.nvim_create_user_command(
    "PynvenvDeactivateVenv",
    utils.deactivate,
    { bang = true, desc = "Deactivate currently activated venv." }
  )

  vim.api.nvim_create_user_command("PynvenvCurrentVenv", utils.current_venv_path, { desc = "Return current venv path" })
end

return M
