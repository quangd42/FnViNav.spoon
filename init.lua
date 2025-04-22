--- === FnViNav ===
---
--- Use fn + hjkl as Vi-style arrow keys, with asd as modifiers (alt, shift, cmd)
---
--- Download: [https://github.com/quangd42/FnViNav.spoon/releases/latest/download/FnViNav.spoon.zip](https://github.com/quangd42/FnViNav.spoon/releases/latest/download/FnViNav.spoon.zip)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "FnViNav"
obj.version = "1.0"
obj.author = "quangd42"
obj.homepage = "https://github.com/quangd42/FnViNav.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

local eventtap = require("hs.eventtap")
local event = eventtap.event

local ARROWS = { h = "left", j = "down", k = "up", l = "right" }
local MODIFERS = { a = "alt", s = "shift", d = "cmd" }

obj.debugging = false
obj.activeModifiers = {
    alt = false,
    shift = false,
    cmd = false,
}

local function keyHandler(e)
    local actualKey = e:getCharacters(true):lower()
    local arrow = ARROWS[actualKey]
    local mod = MODIFERS[actualKey]

    if mod then
        obj.activeModifiers[mod] = (e:getType() == event.types.keyDown)
        if obj.debugging then
            print("Modifier key pressed:", mod, obj.activeModifiers[mod])
        end
        return true, {}
    elseif arrow then
        if e:getType() == event.types.keyDown then
            local activeModifiers = {}
            for m, active in pairs(obj.activeModifiers) do
                if active then
                    table.insert(activeModifiers, m)
                end
            end

            if obj.debugging then
                print("Direction key pressed:", arrow)
                print("Active modifiers:", activeModifiers)
            end

            eventtap.keyStroke(activeModifiers, arrow, 0)
            return true, {}
        end
        return true, {}
    end
    return false
end

local function modifierHandler(e)
    local flags = e:getFlags()
    local onlyFNPressed = false
    for k, v in pairs(flags) do
        onlyFNPressed = v and k == "fn"
        if not onlyFNPressed then
            break
        end
    end

    if onlyFNPressed and not obj.keyListener then
        if obj.debugging then
            print("FnViNav: keyhandler on")
        end
        obj.keyListener = eventtap.new({ event.types.keyDown, event.types.keyUp }, keyHandler):start()
    elseif not flags.fn and obj.keyListener then
        if obj.debugging then
            print("FnViNav: keyhandler off")
        end
        for k in pairs(obj.activeModifiers) do
            obj.activeModifiers[k] = false
        end
        obj.keyListener:stop()
        obj.keyListener = nil
    end
    return false
end

--- FnViNav:start()
--- Method
--- Starts the FnViNav functionality
function obj:start()
    if not self.modifierListener then
        self.modifierListener = eventtap.new({ event.types.flagsChanged }, modifierHandler)
        self.modifierListener:start()
    end
    return self
end

--- FnViNav:stop()
--- Method
--- Stops the FnViNav functionality
function obj:stop()
    if self.keyListener then
        self.keyListener:stop()
        self.keyListener = nil
    end
    if self.modifierListener then
        self.modifierListener:stop()
        self.modifierListener = nil
    end
    for k in pairs(self.activeModifiers) do
        self.activeModifiers[k] = false
    end
    return self
end

return obj
