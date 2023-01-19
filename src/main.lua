require "game"
require "configuration"

------------------------------------------------

function love.load()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(GeneralFont)

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
    elseif key == "f11" then
        GameCore:fullscreen()
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
