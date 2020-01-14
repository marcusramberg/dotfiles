require "pomodoro"
require "usb"
require "utils"
require "wifi"
require "wm"

-- Settings
--

hyper = {"cmd","alt","ctrl","shift"}
hs.window.animationDuration = 0
hs.alert.defaultStyle.strokeColor =  {white = 1, alpha = 0}
hs.alert.defaultStyle.fillColor =  {white = 0.05, alpha = 0.75}
hs.alert.defaultStyle.radius =  10


local ipc = require("hs.ipc")
local hotkey = require "hs.hotkey"

hs.hotkey.bind(hyper, 'c', hs.toggleConsole)

hs.hotkey.bind(hyper, "r", function() hs.reload() end)
hs.hotkey.bind(hyper, 'n', function() hs.task.new("/usr/bin/open", nil, {os.getenv("HOME")}):start() end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(hyper, "b", function() hs.application.launchOrFocus("Vivaldi") end)



hs.ipc.cliInstall()


-- Load SpoonInstall, so we can easily load our other Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall


-- Direct URLs automatically based on patterns
Install:andUse("URLDispatcher",
  {
    config = {
      url_patterns = {
        { "https?://.*.redhat.com", "org.mozilla.firefox" },
        { "https?://microsoft.com/devicelogin", "com.google.Chrome" },
      },
      default_handler = "com.browserosaurus"
    },
    start = true
  }
)


-- EOF
hs.notify.new({
    title='Hammerspoon',
    informativeText='Config loaded'
  }):send()

