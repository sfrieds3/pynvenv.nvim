# pynvenv.nvim

Activate and deactivate python virtualenvs. The easy way.

## Installation

Install using your favorite neovim pacakge manager:


```lua
-- lazy.nvim
{
  "sfrieds3/pynvenv.nvim",
  config = true
}
```

```lua
-- pckr
require("pckr").add({
  {
    "sfrieds3/pynvenv.nvim",
    config = function()
      require("pynvenv").setup({})
    end,
  }
})
```

## Configuration

```lua
config.default_opts = {
  default_venv = nil, -- default venv to source if no venv active upon entering vim
  venv_aliases = {}, -- table of aliases (e.g. { alias = "path/to/alias"}) to make sourcing venv easier
  project_roots = { ".git" }, -- project root markers
  project_venv_dirs = { "venv", ".venv" }, -- list of venv directory names to search for in projects
  workon_home = vim.env.WORKON_HOME or nil, -- WORKON_HOME, or the default directory for venvs (e.g. ~/.venv)
  setup_commands = true, -- create user commands
}
```

## Usage

```
:PyvenvWorkonVenv <venv_name>  " activate venv in $WORKON_HOME
:PyvenvActivateVenv <venv_path> " activate venv_path
:PyvenvDeactiveVevnv " deactivate current venv
:PyvenvActivateVenvAlias " activate venv alias
:PyvenvActivateProjectVenv " activate venv in current project, using config.project_roots and config.project_venv_dirs
```
