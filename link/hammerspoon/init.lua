-- hyper = {"cmd","alt","ctrl"}
hyper = {"cmd","alt","ctrl","shift"}


local ipc = require("hs.ipc")
local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"
local hints = require "hs.hints"

local spaces = require("hs._asm.undocumented.spaces")




hs.hotkey.bind(hyper, "w", function() tiling.cycleLayout()  end)
hs.hotkey.bind(hyper, "j", function() tiling.cycle(1)  end)
hs.hotkey.bind(hyper, "k", function() tiling.cycle(-1) end)
hs.hotkey.bind(hyper, 'y', hs.toggleConsole)
hs.hotkey.bind(hyper, 'n', function() hs.task.new("/usr/bin/open", nil, {os.getenv("HOME")}):start() end)

hs.hotkey.bind(hyper, "space", function() tiling.promote() end)
hs.hotkey.bind(hyper, "m", function() tiling.goToLayout("fullscreen") end)
hs.hotkey.bind(hyper, "r", function() hs.reload() end)
hs.hotkey.bind(hyper, "right", function() hs.screen:next() end)
hs.hotkey.bind(hyper, "left", function() hs.screen:next() end)
hs.hotkey.bind(hyper, "return", function() hs.application.launchOrFocus("iTerm 2") end)
hs.hotkey.bind(hyper, "f", function()
      hs.hints.windowHints()
    end)
 hints.style = "vimperator"

hs.hotkey.bind(hyper,"1", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(1)'") end)
hs.hotkey.bind(hyper,"2", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(2)'") end)
hs.hotkey.bind(hyper,"3", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(3)'") end)
hs.hotkey.bind(hyper,"4", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(4)'") end)
hs.hotkey.bind(hyper,"5", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(5)'") end)
hs.hotkey.bind(hyper,"6", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(6)'") end)
hs.hotkey.bind(hyper,"7", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(7)'") end)
hs.hotkey.bind(hyper,"8", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(8)'") end)
hs.hotkey.bind(hyper,"9", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(9)'") end)

-- Callback function for application events
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "Finder") then
            -- Bring all Finder windows forward when one gets activated
            appObject:selectMenuItem({"Window", "Bring All to Front"})
				end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher):start()

hs.ipc.cliInstall()


local function newChromeWindow()
  os.execute("/Applications/'Google Chrome.app'/Contents/MacOS/'Google Chrome' --new-window")
  visibleWindows = hs.window.orderedWindows()
  visibleWindows[2]:focus()
end

hs.hotkey.bind(hyper, "c", newChromeWindow)


hs.notify.new({
      title='Hammerspoon',
        informativeText='Config loaded'
    }):send()


-- Spaces
local spacesCount = spaces.count()
local spacesModifiers = {"fn", spacesModifier}

-- infinitely cycle through spaces using ctrl+left/right to trigger ctrl+[1..n]
local spacesEventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(o)
  local keyCode = o:getKeyCode()
  local modifiers = o:getFlags()

  --logger.i(keyCode, hs.inspect(modifiers))

  -- check if correct key code
  if keyCode ~= 123 and keyCode ~= 124 then return end
  if not modifiers[spacesModifier] then return end

  -- check if no other modifiers where pressed
  local passed = hs.fnutils.every(modifiers, function(_, modifier)
    return hs.fnutils.contains(spacesModifiers, modifier)
  end)

  if not passed then return end

  -- switch spaces
  local currentSpace = spaces.currentSpace()
  local nextSpace

  -- left arrow
  if keyCode == 123 then
    nextSpace = currentSpace ~= 1 and currentSpace - 1 or spacesCount
   -- right arrow
  elseif keyCode == 124 then
    nextSpace = currentSpace ~= spacesCount and currentSpace + 1 or 1
  end

  hs.eventtap.keyStroke({spacesModifier}, string.format("%d", nextSpace))

  -- stop propagation
  return true
end):start()

hs.hotkey.bind(hyper, "e", function()
  -- this is to bind the spacesEventtap variable to a long-lived function in
  -- order to prevent GC from doing their evil business
  hs.alert.show("Fast space switching enabled: " .. tostring(spacesEventtap:isEnabled()))
end)

-- Wifi
function ssidChangedCallback()
    local ssid = hs.wifi.currentNetwork()
    if ssid then
      hs.alert.show("Network connected: " .. ssid)
    end
end

