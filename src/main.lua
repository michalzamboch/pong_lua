require "game"

------------------------------------------------

MyFontSize = 45
local myFont = love.graphics.newFont(MyFontSize)

MotionConstant = 1
local manipulateMotion = false
Rng = love.math.newRandomGenerator(os.time())

------------------------------------------------

function love.load()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(myFont)

    GameCore = Game:new()
end

function love.update(dt)
    GameCore:update(dt)
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
    elseif key == "f11" then
        GameCore:fullscreen()
    elseif key == "f6" then
        GameCore:pauseGame()
    elseif key == "f9" then
        GameCore:switchModeBat1()
    elseif key == "f10" then
        GameCore:switchModeBat2()
    end
end

function AddMotion(value)
    if manipulateMotion then
        MotionConstant = MotionConstant + value
    end
end
