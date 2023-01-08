require "bat"
require "ball"

------------------------------------------------

function love.load()
    Bat1 = Bat:new()
    Bat1:setPosition(50, 50)
    Bat2 = Bat:new()
    Bat2:setPosition(200, 200)

    --love.window.setFullscreen(true)
end

function love.update(dt)

end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    Bat1:draw()
    Bat2:draw()
end

function love.mousepressed(x, y, b, istouch)
    if b == 1 then

    end
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f4" then
        os.exit()    
    end
end