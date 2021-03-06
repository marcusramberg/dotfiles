-- hyper = {"cmd","alt","ctrl"}
hyper = {"cmd","alt","ctrl","shift"}

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

-- This is a function that fetches the current URL from Safari and types it
hs.hotkey.bind(hyper, 'v', function ()
  script = [[
    tell application "Vivaldi"
        set currentURL to get URL of active tab of first window
    end tell
    return currentURL
    ]]

  ok, result = hs.applescript(script)
  print(result)

  if (ok) then
    hs.eventtap.keyStrokes(result)
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

local anycomplete = require "anycomplete/anycomplete"
anycomplete.registerDefaultBindings(hyper, "g")
