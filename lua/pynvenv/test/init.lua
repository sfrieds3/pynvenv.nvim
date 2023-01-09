local assert = require("luassert")
local pynvenv = require("pynvenv")
local config = require("pynvenv.config")
local utils = require("pynvenv.utils")
local completion = require("pynvenv.completion")

local function test_activate_venv(venv)
  pynvenv.workon(venv)
  assert(vim.env.VIRTUAL_ENV == vim.fn.expand(string.format("%s/%s", config.opts.workon_home, venv)))
end

local function debug(venv)
  P(config)
  print(vim.env.VIRTUAL_ENV)
  print(vim.fn.expand(string.format("%s/%s", config.opts.workon_home, venv)))
end

local function test_all()
  test_activate_venv("venv")
  debug("venv")
end
