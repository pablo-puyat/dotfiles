-- hs.loadSpoon("ClipboardTool")
-- spoon.ClipboardTool:start()
-- spoon.ClipboardTool:bindHotkeys({show_clipboard = {{"cmd", "shift"}, "v"}})

-----------------------------------------------
-- Set up
-----------------------------------------------

local hyper = {"shift", "cmd", "alt", "ctrl"}

-----------------------------------------------
-- hyper 1 to resize window full width
-----------------------------------------------

hs.hotkey.bind(hyper, "1", function()
	local win = hs.window.focusedWindow()
	win:maximize()
end)


-----------------------------------------------
-- hyper 2 to resize window to half width
-----------------------------------------------

hs.hotkey.bind(hyper, "2", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.h = max.h
	f.w = max.w/2
	win:setFrame(f)
	win:centerOnScreen()
end)

-----------------------------------------------
-- hyper 3 to resize window to third of screen size
-----------------------------------------------

hs.hotkey.bind(hyper, "3", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.h = max.h
	f.w = max.w/3
	win:setFrame(f)
	win:centerOnScreen()
end)

-----------------------------------------------
-- hyper 4 to resize window to quarter width
-----------------------------------------------

hs.hotkey.bind(hyper, "4", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.h = max.h
	f.w = max.w/4
	win:setFrame(f)
	win:centerOnScreen()
end)

-----------------------------------------------
-- hyper q to push window left
-----------------------------------------------

hs.hotkey.bind(hyper, "q", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()

	f.y = 0
	f.x = 0
	win:setFrame(f)
end)

-----------------------------------------------
-- hyper e to push window right
-----------------------------------------------

hs.hotkey.bind(hyper, "e", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	f.y = 0
	f.x = max.w - f.w
	win:setFrame(f)
end)

-----------------------------------------------
-- hyper w to center window
-----------------------------------------------

hs.hotkey.bind(hyper, "w", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	f.y = 0
	f.h = max.h
	win:setFrame(f)
	win:centerOnScreen()

end)

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
	hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")

