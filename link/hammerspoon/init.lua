
hs.window.animationDuration = 0

-- hyper = {"cmd","alt","ctrl"}
hyper = {"cmd","alt","ctrl","shift"}

local ipc = require("hs.ipc")
local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"
local hints = require "hs.hints"

local spaces = require("hs._asm.undocumented.spaces")


hs.hotkey.bind(hyper, "[", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.left50) end)
hs.hotkey.bind(hyper, "]", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.right50) end)
hs.hotkey.bind(hyper, "w", function() tiling.cycleLayout()  end)
hs.hotkey.bind(hyper, "j", function() tiling.cycle(1)  end)
hs.hotkey.bind(hyper, "k", function() tiling.cycle(-1) end)
hs.hotkey.bind(hyper, 'c', hs.toggleConsole)
hs.hotkey.bind(hyper, 'n', function() hs.task.new("/usr/bin/open", nil, {os.getenv("HOME")}):start() end)

hs.hotkey.bind(hyper, "\\", function() tiling.promote() end)
hs.hotkey.bind(hyper, "m", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.maximized) end)
hs.hotkey.bind(hyper, "r", function() hs.reload() end)
hs.hotkey.bind(hyper, "h", function() hs.screen:next() end)
hs.hotkey.bind(hyper, "l", function() hs.screen:next() end)
hs.hotkey.bind(hyper, "t", function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(hyper, "b", function() hs.application.launchOrFocus("Vivaldi") end)
hs.hotkey.bind(hyper, "f", function()
  hs.hints.windowHints()
end)

hs.hotkey.bind(hyper,"1", function() MoveWindowToSpace(1) end)
hs.hotkey.bind(hyper,"2", function() MoveWindowToSpace(2) end)
hs.hotkey.bind(hyper,"3", function() MoveWindowToSpace(3) end)
hs.hotkey.bind(hyper,"4", function() MoveWindowToSpace(4) end)
hs.hotkey.bind(hyper,"5", function() MoveWindowToSpace(5) end)
hs.hotkey.bind(hyper,"6", function() MoveWindowToSpace(6) end)
hs.hotkey.bind(hyper,"7", function() MoveWindowToSpace(7) end)
hs.hotkey.bind(hyper,"8", function() MoveWindowToSpace(8) end)




hs.hotkey.bind(hyper, "u", function()
    local image = hs.pasteboard.readImage()

    if image then
      local tempfile = "/tmp/tmp.png"
      image:saveToFile(tempfile)
      local b64 = hs.execute("base64 -i "..tempfile)
      b64 = hs.http.encodeForQuery(string.gsub(b64, "\n", ""))

      local url = "https://api.imgur.com/3/upload.json"
      local headers = {Authorization = "Client-ID ".. hs.settings.get("imgurKey")} -- hs.settings.get("imgurKey")}
      local payload = "type='base64'&image="..b64

      hs.http.asyncPost(url, payload, headers, function(status, body, headers)
          print(status, headers, body)
          if status == 200 then
            local response = hs.json.decode(body)
            local imageURL = response.data.link
            hs.urlevent.openURLWithBundle(imageURL, hs.urlevent.getDefaultHandler("http"))
          end
        end)
    end
  end)
-- Callback function for application events
--
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

-- hs.hotkey.bind(hyper, "b", newChromeWindow)


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

function MoveWindowToSpace(sp)
    local win = hs.window.focusedWindow()      -- current window
    local uuid = win:screen():spacesUUID()     -- uuid for current screen
    local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
    spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
    spaces.changeToSpace(spaceID)              -- follow window to new space
    hs.notify.new({
        title='Spaces',
        informativeText='Window moved to Space #' .. sp
      }):send()

end


hs.hotkey.bind(hyper, 'y', function ()
  -- Get the focused window, its window frame dimensions, its screen frame dimensions,
  -- and the next screen's frame dimensions.
  local focusedWindow = hs.window.focusedWindow()
  local focusedScreenFrame = focusedWindow:screen():frame()
  local nextScreenFrame = focusedWindow:screen():next():frame()
  local windowFrame = focusedWindow:frame()

  -- Calculate the coordinates of the window frame in the next screen and retain aspect ratio
  windowFrame.x = ((((windowFrame.x - focusedScreenFrame.x) / focusedScreenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x)
  windowFrame.y = ((((windowFrame.y - focusedScreenFrame.y) / focusedScreenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y)
  windowFrame.h = ((windowFrame.h / focusedScreenFrame.h) * nextScreenFrame.h)
  windowFrame.w = ((windowFrame.w / focusedScreenFrame.w) * nextScreenFrame.w)

  -- Set the focused window's new frame dimensions
  focusedWindow:setFrame(windowFrame)
end)


-- This is a function that fetches the current URL from Safari and types it
hs.hotkey.bind(hyper, 'v', function ()
    script = [[
    tell application "Safari"
        set currentURL to URL of document 1
    end tell
    return currentURL
    ]]
    ok, result = hs.applescript(script)
    if (ok) then
        hs.eventtap.keyStrokes(result)
    end
  end)

local anycomplete = require "anycomplete/anycomplete"
anycomplete.registerDefaultBindings({"cmd", "ctrl", "alt", "shift"}, "G")
