require "game"
require "general.configuration"

------------------------------------------------

function love.load()
    CurrentNetRole = NetRole.client

    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(GeneralFont)

    LoadSounds()

    GameCore = Game:new()
end

function love.update(dt)
    GameCore:update()
end

function love.draw()
    GameCore:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        os.exit()
    elseif key == "f1" then
        AddMotion(-0.1)
    elseif key == "f2" then
        AddMotion(0.1)
    elseif key == "f5" then
        GameCore:reset()
    elseif key == "f6" or key == "p" then
        GameCore:pauseGame()
    elseif key == "f9" then
        GameCore:switchModeBatLeft()
    elseif key == "f10" then
        GameCore:switchModeBatRight()
    elseif key == "f12" then
        GameCore:showFPS()
    elseif key == "m" then
        Mute = not Mute
    end
end

------------------------------------------------

function LoadSounds()
    BounceSound = love.audio.newSource(SoundPath .. "bounce.mp3", "static")
    PointUpSound = love.audio.newSource(SoundPath .. "score.mp3", "static")
    PointUpSound:setVolume(Volume)
    WinSound = love.audio.newSource(SoundPath .. "win.mp3", "static")
    WinSound:setVolume(Volume)
end

function AddMotion(value)
    if ManipulateMotion then
        MotionConstant = MotionConstant + value
    end
end

function PlaySound(sound)
    if not Mute then
        sound:play()
    end
end

function Split(s, delimiter)
    local result = {}
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

function toboolean(string)
    local stringtoboolean = { ["true"] = true,["false"] = false }
    return stringtoboolean[string]
end
