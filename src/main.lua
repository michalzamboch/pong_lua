Bat = {
    x = 0,
    y = 0,
    w = 0,
    h = 0
}

function Bat.new(self, x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    return self
end

function Bat.draw(self)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

------------------------------------------------------------------------

function love.load()

end

function love.update(dt)

end

function love.draw()

end

function love.mousepressed(x, y, b, istouch)
    if b == 1 then
        
    end
end

function distanceBetween(x1, y1, x2, y2)
    local yRes = (y2 - y1) ^ 2
    local xRes = (x2 - x1) ^ 2
    return math.sqrt(yRes + xRes)
end
