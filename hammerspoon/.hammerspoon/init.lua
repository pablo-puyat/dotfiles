-----------------------------------------------
-- Set up
-----------------------------------------------

local hyper = {"shift", "cmd", "alt", "ctrl"}

-----------------------------------------------
-- hyper left to cycle between 
-- left 1/2, 1/3, 1/4
-----------------------------------------------

hs.hotkey.bind(hyper, "left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    local sections
	
    if f.w >= math.floor(max.w / 2) then
        sections = 3
    elseif f.w >= math.floor(max.w / 3) then
		sections = 4
	else
		sections = 2
    end

    f.x = 0 
    f.y = 0
    f.w = math.floor(max.w / sections)
    f.h = max.h
    win:setFrame(f)
end)

-----------------------------------------------
-- hyper right to cycle between
-- right 1/2, 1/3, 1/4
-----------------------------------------------

hs.hotkey.bind(hyper, "right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if f.w >= math.floor(max.w / 2) then
		f.x = max.w - math.floor(max.w / 3)
		f.w = math.floor(max.w / 3)
    elseif f.w >= math.floor(max.w / 3) then
		f.x = max.w - (max.w / 4)
		f.w = math.floor(max.w / 4)
	else
		f.x = math.floor(max.w / 2)
		f.w = max.w / 2
    end

    f.y = max.y
    f.h = max.h
    win:setFrame(f)
end)

-----------------------------------------------
-- hyper down to cycle through
-- center 1/2, 1/3, 3/4
-----------------------------------------------

hs.hotkey.bind(hyper, "down", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    if f.w >= max.w - math.floor(max.w / 4) then
        f.x = math.floor(max.w / 4) 
        f.y = 0
        f.w = math.floor(max.w / 2)
        f.h = max.h
	elseif f.w >= math.floor(max.w /2) then
        f.x = math.floor(max.w / 3) 
        f.y = 0
        f.w = math.floor(max.w / 3)
        f.h = max.h
    else
        f.x = math.floor(max.w / 4) 
        f.y = 0
        f.w = max.w - math.floor(max.w / 4)
        f.h = max.h
    end

    win:setFrame(f)
end)

-----------------------------------------------
-- hyper up for fullscreen
-----------------------------------------------

hs.hotkey.bind(hyper, "up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
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

