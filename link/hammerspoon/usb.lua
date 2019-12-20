-- Callback function for USB device events
function usbDeviceCallback(data)
    print("usbDeviceCallback: "..hs.inspect(data))
    if (data["productName"] == "Wireless Controller" and data["vendorName"] == "Sony Computer Entertainment") then
        event = data["eventType"]
        if (event == "added") then
            hs.application.launchOrFocus("RemotePlay")
            hs.itunes.pause()
        elseif (event == "removed") then
            app = hs.appfinder.appFromName("PS4 Remote Play")
            app:kill()
        end
    end
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()

