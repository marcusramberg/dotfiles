-- Defines for WiFi watcher
homeSSID = "means.no" -- My home WiFi SSID
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    print("ssidChangedCallback: old:"..(lastSSID or "nil").." new:"..(newSSID or "nil"))
    if newSSID == homeSSID and lastSSID ~= homeSSID then
        -- We have gone from something that isn't my home WiFi, to something that is
        home_arrived()
    elseif newSSID ~= homeSSID and lastSSID == homeSSID then
        -- We have gone from something that is my home WiFi, to something that isn't
        home_departed()
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()


-- Perform tasks to configure the system for my home WiFi network
function home_arrived()
    -- Note: sudo commands will need to have been pre-configured in /etc/sudoers, for passwordless access, e.g.:
    -- cmsj ALL=(root) NOPASSWD: /usr/libexec/ApplicationFirewall/socketfilterfw --setblockall *
    hs.task.new("/usr/bin/sudo", function() end, {"/usr/libexec/ApplicationFirewall/socketfilterfw", "--setblockall", "off"})

    -- Mount my NAS
    hs.applescript.applescript([[
        tell application "Finder"
            try
                mount volume "smb://mhub.lan/Space"
            end try
        end tell
    ]])
    hs.notify.new({
          title='Hammerspoon',
            informativeText='Mounted volumes, disabled firewall'
        }):send()
end

-- Perform tasks to configure the system for any WiFi network other than my home
function home_departed()
    hs.task.new("/usr/bin/sudo", function() end, {"/usr/libexec/ApplicationFirewall/socketfilterfw", "--setblockall", "on"})
    hs.applescript.applescript([[
        tell application "Finder"
            eject "Space"
        end tell
    ]])

    hs.notify.new({
          title='Hammerspoon',
            informativeText='Unmounted volumes, enabled firewall'
        }):send()
end



