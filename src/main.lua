require "game"

------------------------------------------------

function love.load()
    love.graphics.setColor(255, 255, 255)

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
    elseif key == "f5" then
        GameCore:reset()
    elseif key == "f11" then
        Fullscreen = not Fullscreen
        love.window.setFullscreen(Fullscreen)
    elseif key == "f6" then
        GameCore:pauseGame()
    end
end
