-----------------------------------------------
-- Set up
-----------------------------------------------

local hyper = {"shift", "cmd", "alt", "ctrl"}

-----------------------------------------------
-- hyper left to push window 
-- left half / third of screen
-----------------------------------------------

hs.hotkey.bind(hyper, "left", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	local halfsize = math.floor(max.w / 2)
	local thirdsize = math.floor(max.w / 3)
        if f.w >= halfsize - 10 and f.w <= halfsize + 10  then
		f.w = thirdsize
	else
		f.w = halfsize
	end
	f.y = 0
	f.x = 0
	f.h = max.h
	win:setFrame(f)
end)

-----------------------------------------------
-- hyper right to push window 
-- right half / third of screen
-----------------------------------------------

hs.hotkey.bind(hyper, "right", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	local halfsize = math.floor(max.w / 2)
	local thirdsize = math.floor(max.w / 3)
        if f.w >= halfsize - 10 and f.w <= halfsize + 10  then
		f.x = thirdsize * 2
		f.w = thirdsize
	else
		f.x = halfsize
		f.w = halfsize
	end
	f.y = 0
	f.h = max.h
	win:setFrame(f)
end)

-----------------------------------------------
-- hyper down to cycle through
-- center 1/2, 1/3
-----------------------------------------------

hs.hotkey.bind(hyper, "down", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	local halfsize = math.floor(max.w / 2)
	local thirdsize = math.floor(max.w / 3)
        if f.w >= halfsize - 10 and f.w <= halfsize + 10  then
		f.x = thirdsize
		f.w = thirdsize
	else 
		f.x = math.floor(max.w / 4) 
		f.w = halfsize
	end
	f.y = 0
	f.h = max.h

	win:setFrame(f)
end)

-----------------------------------------------
-- hyper up for push up
-----------------------------------------------
hs.hotkey.bind(hyper, "up", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.w = max.w
	f.h = math.floor(max.h /2)
	if f.y <= 50 then 
		f.y = math.floor(max.h / 2) + 20
	else
		f.y = 0
	end
	f.x = 0

	win:setFrame(f)
end)

-----------------------------------------------
-- hyper space for fullscreen
-----------------------------------------------
hs.hotkey.bind(hyper, "space", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.w = max.w
	f.h = max.h
	f.x = 0
	f.y = 0

	win:setFrame(f)
end)

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reload_config(files)
	hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")

