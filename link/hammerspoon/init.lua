require "pomodoro"
require "usb"
require "utils"
require "wifi"
require "wm"

hyper = {"cmd","alt","ctrl","shift"}
hs.window.animationDuration = 0

local ipc = require("hs.ipc")
local hotkey = require "hs.hotkey"

hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

hs.hotkey.bind(hyper, "r", function() hs.reload() end)
hs.hotkey.bind(hyper, 'n', function() hs.task.new("/usr/bin/open", nil, {os.getenv("HOME")}):start() end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(hyper, "b", function() hs.application.launchOrFocus("Vivaldi") end)





hs.ipc.cliInstall()



-- EOF
hs.notify.new({
    title='Hammerspoon',
    informativeText='Config loaded'
  }):send()

