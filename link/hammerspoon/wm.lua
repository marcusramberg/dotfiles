local hyper = {"cmd", "alt", "ctrl", "shift"}
local cmd = {"cmd"}
local cmd_shift = {"cmd", "shift"}

local spaces = require("hs._asm.undocumented.spaces")
local lastSpace = nil
local logger = hs.logger.new("wm", "info")

hs.application.enableSpotlightForNameSearches(true)
hs.window.switcher.ui.fontName = 'Verdana'

hs.hotkey.bind(hyper, "o", function() hs.window.focusedWindow():moveToUnit(hs.layout.left50) end)
hs.hotkey.bind(hyper, "p", function() hs.window.focusedWindow():moveToUnit(hs.layout.right50) end)
hs.hotkey.bind(hyper, "k", function() hs.window.focusedWindow():moveToUnit(hs.layout.left70) end)
hs.hotkey.bind(hyper, "l", function() hs.window.focusedWindow():moveToUnit(hs.layout.right30) end)
hs.hotkey.bind(hyper, "m", function() hs.window.focusedWindow():moveToUnit(hs.layout.maximized) end)

local table_invert = function(t)
   local s={}
   for k,v in pairs(t) do
     s[v]=k
   end
   return s
end

local switchToSpace = function(sp)
  local layout = spaces.layout()[spaces.mainScreenUUID()]
  if (layout[sp] == spaces.activeSpace() and lastSpace ~= nil) then
    sp = lastSpace
  end
  local invert_layout=table_invert(layout)
  lastSpace = invert_layout[spaces.activeSpace()]
  spaces.changeToSpace(layout[sp], true)
end


hs.hotkey.bind(cmd, "1", function() switchToSpace(1) end)
hs.hotkey.bind(cmd, "2", function() switchToSpace(2) end)
hs.hotkey.bind(cmd, "3", function() switchToSpace(3) end)
hs.hotkey.bind(cmd, "4", function() switchToSpace(4) end)
hs.hotkey.bind(cmd, "5", function() switchToSpace(5) end)
hs.hotkey.bind(cmd, "6", function() switchToSpace(6) end)
hs.hotkey.bind(cmd, "7", function() switchToSpace(7) end)
hs.hotkey.bind(cmd, "8", function() switchToSpace(8) end)

local moveWindowToSpace = function(sp)
  local win = hs.window.focusedWindow() -- current window
  local uuid = win:screen():spacesUUID() -- uuid for current screen
  local spaceID = spaces.layout()[uuid][sp] -- internal index for sp
  spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
  spaces.changeToSpace(spaceID) -- follow window to new space
  hs.notify.new({title = 'Spaces', informativeText = 'Window moved to Space #' .. sp}):send()

end

hs.hotkey.bind(cmd_shift, "1", function() moveWindowToSpace(1) end)
hs.hotkey.bind(cmd_shift, "2", function() moveWindowToSpace(2) end)
hs.hotkey.bind(cmd_shift, "3", function() moveWindowToSpace(3) end)
hs.hotkey.bind(cmd_shift, "4", function() moveWindowToSpace(4) end)
hs.hotkey.bind(cmd_shift, "5", function() moveWindowToSpace(5) end)
hs.hotkey.bind(cmd_shift, "6", function() moveWindowToSpace(6) end)
hs.hotkey.bind(cmd_shift, "7", function() moveWindowToSpace(7) end)
hs.hotkey.bind(cmd_shift, "8", function() moveWindowToSpace(8) end)

hs.hotkey.bind(cmd, "left", function() hs.window.focusedWindow().focusWindowWest() end)
hs.hotkey.bind(cmd, "right", function() hs.window.focusedWindow().focusWindowEast() end)
hs.hotkey.bind(cmd, "up", function() hs.window.focusedWindow().focusWindowNorth() end)
hs.hotkey.bind(cmd, "down", function() hs.window.focusedWindow().focusWindowSouth() end)

local switcher_space = hs.window.switcher.new(hs.window.filter.new {override = {fullscreen = false}}:setCurrentSpace(
                                                true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt', 'tab', function() switcher_space:next() end)
hs.hotkey.bind('alt-shift', 'tab', function() switcher_space:previous() end)

-- Spaces
local spacesCount = spaces.count()
local spacesModifiers = {"ctrl"}

-- infinitely cycle through spaces using ctrl+left/right to trigger ctrl+[1..n]
local spacesEventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(o)
  local keyCode = o:getKeyCode()
  local modifiers = o:getFlags()

  -- logger.i(keyCode, hs.inspect(modifiers))

  -- check if correct key code
  if keyCode ~= 123 and keyCode ~= 124 then return end
  if not modifiers[spacesModifiers] then return end

  -- check if no other modifiers where pressed
  local passed = hs.fnutils.every(modifiers,
                                  function(_, modifier) return hs.fnutils.contains(spacesModifiers, modifier) end)

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

  hs.eventtap.keyStroke({spacesModifiers}, string.format("%d", nextSpace))

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

hs.hotkey.bind(hyper, 'y', function()
  -- Get the focused window, its window frame dimensions, its screen frame dimensions,
  -- and the next screen's frame dimensions.
  local focusedWindow = hs.window.focusedWindow()
  local focusedScreenFrame = focusedWindow:screen():frame()
  local nextScreenFrame = focusedWindow:screen():next():frame()
  local windowFrame = focusedWindow:frame()

  -- Calculate the coordinates of the window frame in the next screen and retain aspect ratio
  windowFrame.x = ((((windowFrame.x - focusedScreenFrame.x) / focusedScreenFrame.w) * nextScreenFrame.w) +
                    nextScreenFrame.x)
  windowFrame.y = ((((windowFrame.y - focusedScreenFrame.y) / focusedScreenFrame.h) * nextScreenFrame.h) +
                    nextScreenFrame.y)
  windowFrame.h = ((windowFrame.h / focusedScreenFrame.h) * nextScreenFrame.h)
  windowFrame.w = ((windowFrame.w / focusedScreenFrame.w) * nextScreenFrame.w)

  -- Set the focused window's new frame dimensions
  focusedWindow:setFrame(windowFrame)
end)

