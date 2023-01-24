require "game"
require "configuration"
Socket = require "socket"

------------------------------------------------

function love.load()
    CurrentNetRole = NetRole.client

    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(GeneralFont)

    BounceSound = love.audio.newSource("assets/bounce.mp3", "static")
    BounceSound:setVolume(Volume)
    PointUpSound = love.audio.newSource("assets/score.mp3", "static")
    PointUpSound:setVolume(Volume)
    WinSound = love.audio.newSource("assets/win.mp3", "static")
    WinSound:setVolume(Volume)

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
    elseif key == "f3" then
        AddSize(-0.1)
    elseif key == "f4" then
        AddSize(0.1)
    elseif key == "f5" then
        GameCore:reset()
    elseif key == "f6" then
        GameCore:pauseGame()
    elseif key == "f9" then
        GameCore:switchModeBat1()
    elseif key == "f10" then
        GameCore:switchModeBat2()
    end
end

function AddMotion(value)
    if ManipulateMotion then
        MotionConstant = MotionConstant + value
    end
end

function AddSize(value)
    if ManipulateSize then
        SizeConstant = SizeConstant + value
    end
end

function PlaySound(sound)
    if not Mute then
        sound:play()
    end
end
