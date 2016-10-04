k = hs.hotkey.modal.new({}, "F17")

local ipc = require("hs.ipc")
local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"
local hints = require "hs.hints"

local spaces = require("hs._asm.undocumented.spaces")




k:bind({}, "w", function() tiling.cycleLayout() ; k.triggered=true end)
k:bind({}, "j", function() tiling.cycle(1) ; k.triggered=true end)
k:bind({}, "k", function() tiling.cycle(-1) ; k.triggered=true end)
k:bind({}, 'y', hs.toggleConsole)
k:bind({}, 'n', function() hs.task.new("/usr/bin/open", nil, {os.getenv("HOME")}):start() ; k.triggered=true end)

k:bind({}, "space", function() tiling.promote() ; k.triggered=true end)
k:bind({}, "m", function() tiling.goToLayout("fullscreen") ; k.triggered=true end)
k:bind({}, "r", function() hs.reload() ; k.triggered=true end)
k:bind({}, "right", function() hs.screen:next() ; k.triggered=true end)
k:bind({}, "left", function() hs.screen:next() ; k.triggered=true end)
k:bind({}, "return", function() hs.application.launchOrFocus("iTerm") ; k.triggered=true end)
k:bind({}, "f", function()
      hs.hints.windowHints(); k.triggered=true 
    end)
 hints.style = "vimperator"

k:bind({},"1", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(1)'"); k.triggered=true end)
k:bind({},"2", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(2)'"); k.triggered=true end)
k:bind({},"3", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(3)'"); k.triggered=true end)
k:bind({},"4", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(4)'"); k.triggered=true end)
k:bind({},"5", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(5)'"); k.triggered=true end)
k:bind({},"6", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(6)'"); k.triggered=true end)
k:bind({},"7", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(7)'"); k.triggered=true end)
k:bind({},"8", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(8)'"); k.triggered=true end)
k:bind({},"9", function() os.execute("ruby -rtotalspaces2 -e'TotalSpaces2.move_to_space(9)'"); k.triggered=true end)

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

k:bind({}, "c", function()
  newChromeWindow(); k.triggered=true 
end)


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

k:bind({}, "e", function()
  -- this is to bind the spacesEventtap variable to a long-lived function in
  -- order to prevent GC from doing their evil business
  hs.alert.show("Fast space switching enabled: " .. tostring(spacesEventtap:isEnabled()))
  k.triggered=true 
end)

-- Wifi
function ssidChangedCallback()
    local ssid = hs.wifi.currentNetwork()
    if ssid then
      hs.alert.show("Network connected: " .. ssid)
    end
end

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind("", 'F18', pressedF18, releasedF18)
