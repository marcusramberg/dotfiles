require "pomodoro"
require "usb"
require "utils"
require "wifi"
require "wm"


local ipc = require("hs.ipc")

-- Settings

hs.logger.defaultLogLevel='debug'
hs.window.animationDuration = 0
hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius =  10

-- Keybindings
local hyper = {"cmd","alt","ctrl","shift"}
hs.hotkey.bind(hyper, 'c', hs.toggleConsole)
hs.hotkey.bind(hyper, "r", function() hs.reload() end)
hs.hotkey.bind(hyper, 'n', function() hs.task.new("/usr/bin/open", nil, {os.getenv("HOME")}):start() end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(hyper, "b", function() hs.application.launchOrFocus("Firefox Developer Edition") end)

ipc.cliInstall()

-- Load SpoonInstall, so we can easily load our other Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
local Install=spoon.SpoonInstall

hs.notify.new({
    title='Hammerspoon',
    informativeText='Config loaded'
  }):send()
