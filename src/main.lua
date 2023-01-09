require "bat"
require "ball"

------------------------------------------------

ScreenHeight = love.graphics.getPixelHeight()
ScreenWidth = love.graphics.getPixelWidth()

function love.load()
    Bat1 = Bat:new()
    Bat1:setPosition(50, 50)
    Bat1.player = PlayerId.player1

    Bat2 = Bat:new()
    Bat2:setPosition(200, 200)
    Bat2.player = PlayerId.player2

    Ball1 = Ball:new()

    love.graphics.setColor(255, 255, 255)
end

function love.update(dt)
    moveBats(dt)

    Ball1:move(dt, Bat1, Bat2)
end

function moveBats(dt)
    if love.keyboard.isDown("down") then
        Bat1:down(dt)
    elseif love.keyboard.isDown("up") then
        Bat1:up(dt)
    end

    if love.keyboard.isDown("s") then
        Bat2:down(dt)
    elseif love.keyboard.isDown("w") then
        Bat2:up(dt)
    end
end

function love.draw()
    Bat1:draw()
    Bat2:draw()

    Ball1:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "f4" or key == "escape" then
        os.exit()
    elseif key == "f11" then
        Fullscreen = not Fullscreen
        love.window.setFullscreen(Fullscreen)
    elseif key == "f5" then
        -- reset
    end
end
