hyper = {"cmd","alt","ctrl","shift"}
alt = {"alt"}
alt_shift = {"alt","shift"}
cmd = {"cmd"}
cmd_shift = {"cmd","shift"}
cmd_ctrl = {"cmd","ctrl"}
cmd_alt = {"cmd","alt"}

local spaces = require("hs._asm.undocumented.spaces")
local hints = require "hs.hints"
local lastSpace = nil
local logger = hs.logger.new("wm","info")




hs.hotkey.bind(hyper, "o", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.left50) end)
hs.hotkey.bind(hyper, "p", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.right50) end)
hs.hotkey.bind(hyper, "k", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.left70) end)
hs.hotkey.bind(hyper, "l", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.right30) end)
hs.hotkey.bind(hyper, "m", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.maximized) end)

--hs.hotkey.bind(hyper, "f", function() hs.hints.windowHints() end)

hs.hotkey.bind(cmd,"1", function() SwitchToSpace(1) end)
hs.hotkey.bind(cmd,"2", function() SwitchToSpace(2) end)
hs.hotkey.bind(cmd,"3", function() SwitchToSpace(3) end)
hs.hotkey.bind(cmd,"4", function() SwitchToSpace(4) end)
hs.hotkey.bind(cmd,"5", function() SwitchToSpace(5) end)
hs.hotkey.bind(cmd,"6", function() SwitchToSpace(6) end)
hs.hotkey.bind(cmd,"7", function() SwitchToSpace(7) end)
hs.hotkey.bind(cmd,"8", function() SwitchToSpace(8) end)


hs.hotkey.bind(cmd_shift,"1", function() MoveWindowToSpace(1) end)
hs.hotkey.bind(cmd_shift,"2", function() MoveWindowToSpace(2) end)
hs.hotkey.bind(cmd_shift,"3", function() MoveWindowToSpace(3) end)
hs.hotkey.bind(cmd_shift,"4", function() MoveWindowToSpace(4) end)
hs.hotkey.bind(cmd_shift,"5", function() MoveWindowToSpace(5) end)
hs.hotkey.bind(cmd_shift,"6", function() MoveWindowToSpace(6) end)
hs.hotkey.bind(cmd_shift,"7", function() MoveWindowToSpace(7) end)
hs.hotkey.bind(cmd_shift,"8", function() MoveWindowToSpace(8) end)

hs.hotkey.bind(cmd,"left", function()  hs.window.focusedWindow().focusWindowWest() end)
hs.hotkey.bind(cmd,"right", function()  hs.window.focusedWindow().focusWindowEast() end)
hs.hotkey.bind(cmd,"up", function()  hs.window.focusedWindow().focusWindowNorth() end)
hs.hotkey.bind(cmd,"down", function()  hs.window.focusedWindow().focusWindowSouth() end)


hs.window.switcher.ui.fontName = 'Verdana'
switcher_space = hs.window.switcher.new(hs.window.filter.new{override={fullscreen=false}}:setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','tab', function()switcher_space:next()end)
hs.hotkey.bind('alt-shift','tab', function()switcher_space:previous()end)

-- Spaces
local spacesCount = spaces.count()
local spacesModifiers = {"ctrl" }



-- Focus windows by direction (like tmux)
local function focus(direction)
  local fn = "focusWindow" .. (direction:gsub("^%l", string.upper))

  return function()
    local win = hs.window:focusedWindow()
    if not win then return end

    win[fn]()
  end
end

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
  hs.application.find("Emacs"):activate()
  print("Fast space switching enabled: " .. tostring(spacesEventtap:isEnabled()))
end)

-- function yabai(args)

--   -- Runs in background very fast
--   hs.task.new("/usr/local/bin/yabai",nil, function(ud, ...)
--     print("stream", hs.inspect(table.pack(...)))
--     return true
--   end, args):start()

-- end

function SwitchToSpace(sp)
    logger.i(sp,lastSpace,spaces.activeSpace())
    layout = spaces.layout()[spaces.mainScreenUUID()]
    if (layout[sp] == spaces.activeSpace() and lastSpace ~= nil) then
       sp = lastSpace
    end
    lastSpace = spaces.activeSpace()
    print("Changing to " .. sp .. " - " .. layout[sp] .. " - " .. lastSpace)
    spaces.changeToSpace(layout[sp], true)
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

function setOnSpace(application, sp, layout)
  layout = layout or hs.layout.maximized
  print("Mooving",application, sp, layout)
  local app = hs.application.open(application, 5, true)
  if not app then
    print("Failed to focus", application)
    return
  end
  local win = hs.window.focusedWindow()      -- current window
  local uuid = win:screen():spacesUUID()     -- uuid for current screen
  local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
  spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
  win:moveToUnit(layout)
end

hs.application.enableSpotlightForNameSearches(true)

-- hs.hotkey.bind(hyper, "h", function()
--   setOnSpace("iTerm", 1)
--   setOnSpace("Firefox Developer Edition", 2, hs.layout.left70)
--   setOnSpace("Emacs", 3)
--   setOnSpace("Slack", 4, hs.layout.left70)
--   setOnSpace("Telegram", 4, hs.layout.left70)
--   setOnSpace("Microsoft Outlook", 4, hs.layout.left70)
--   setOnSpace("Convos", 4, hs.layout.right30)
--   setOnSpace("YT Music", 5, hs.layout.right50)
--   setOnSpace("Guacamole", 6)
--   hs.notify.new({
--       title='Home',
--       informativeText='Windows Configured'
--     }):send()

-- end)

function emacsclientWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    if (appName == "EmacsClient") then
      -- Bring Emacs to Front
      hs.osascript.applescript('tell application "Emacs" to activate')
    end
  end
end
appWatcher = hs.application.watcher.new(emacsclientWatcher)
appWatcher:start()
