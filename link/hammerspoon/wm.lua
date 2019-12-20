hyper = {"cmd","alt","ctrl","shift"}
local spaces = require("hs._asm.undocumented.spaces")
local hints = require "hs.hints"

hs.hotkey.bind(hyper, "[", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.left50) end)
hs.hotkey.bind(hyper, "]", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.right50) end)
hs.hotkey.bind(hyper, "m", function() local win = hs.window.focusedWindow(); win:moveToUnit(hs.layout.maximized) end)

hs.hotkey.bind(hyper, "w", function() tiling.cycleLayout()  end)
hs.hotkey.bind(hyper, "j", function() tiling.cycle(1)  end)
hs.hotkey.bind(hyper, "k", function() tiling.cycle(-1) end)
hs.hotkey.bind(hyper, "\\", function() tiling.promote() end)

hs.hotkey.bind(hyper, "f", function() hs.hints.windowHints() end)

hs.hotkey.bind(hyper,"1", function() MoveWindowToSpace(1) end)
hs.hotkey.bind(hyper,"2", function() MoveWindowToSpace(2) end)
hs.hotkey.bind(hyper,"3", function() MoveWindowToSpace(3) end)
hs.hotkey.bind(hyper,"4", function() MoveWindowToSpace(4) end)
hs.hotkey.bind(hyper,"5", function() MoveWindowToSpace(5) end)
hs.hotkey.bind(hyper,"6", function() MoveWindowToSpace(6) end)
hs.hotkey.bind(hyper,"7", function() MoveWindowToSpace(7) end)

hs.hotkey.bind(hyper,"8", function() MoveWindowToSpace(8) end)
hs.hotkey.bind(hyper, "h", function() hs.screen:next() end)
hs.hotkey.bind(hyper, "l", function() hs.screen:next() end)

switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt','tab','Next window',function()switcher_space:next()end)
hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher_space:previous()end)

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
